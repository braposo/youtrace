require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  has_many :groups_users
  has_many :groups, :through => :groups_users  
  has_many :subscriptions
  has_many :subscribers, :through => :subscriptions
  has_many :events, :dependent => :destroy
  has_many :traces, :dependent => :destroy
  has_and_belongs_to_many :bookmarks
  has_and_belongs_to_many :vehicles
  has_and_belongs_to_many :devices
  
  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  before_create :make_activation_code 

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :name, :location_lat, :location_lon, :birthdate, :gender, :password, :password_confirmation, :login, :email

  acts_as_tagger

  # Activates the user in the database.
  def activate!
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find :first, :conditions => ['login = ? and activated_at IS NOT NULL', login] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  #Check if current_user has :user as follower
  def has_follower?(user)
    if user.class != User
      @user = User.find_by_login(user)
    else
      @user = user
    end
    
    @user.subscriptions.find_by_subscriber_id(self) ? true : false
  end
  
  #Check if current user is following :user
  def is_following?(user)
    if user.class != User
      @user = User.find_by_login(user)
    else
      @user = user
    end
    
     self.subscriptions.find_by_subscriber_id(@user) ? true : false
  end
  
  def has_bookmark?(tag)
    self.bookmarks.find_by_name tag
  end
  
  def in_group?(group)
     self.groups.find_by_id group
  end
  
  #Return list of authorized user bookmarks
  def authorized_users
    @subs = self.subscriptions.find :all, :conditions => 'authorized = true'
    @subs.map!{ |s| s.subscriber }
  end
  
  #Return list of authorized followers
  def authorized_followers
    @subs = Subscription.find :all, :conditions => ['subscriber_id = ? AND authorized = true', self.id]
    @subs.map!{ |s| User.find_by_id(s.user_id) }
  end
  
  #Return list of pending requests to user
  def pending_requests
    @subs = Subscription.find :all, :conditions => ['subscriber_id = ? AND authorized = false', self.id]
    @subs.map!{ |s| s.user }
  end
  
  #Return list of pending request from user
  def pending_bookmarks
    @subs = self.subscriptions.find :all, :conditions => 'authorized = false'
    @subs.map!{ |s| s.subscriber }
  end
  
  #Authorize follower
  def authorize_follower(user)
    @user = User.find_by_login(user)
    @sub = @user.subscriptions.find_by_subscriber_id self.id
    @sub.update_attributes(:authorized => true)
    Event.create(:user_id => self.id, :format => "add_book", :text => "Authorized request from @#{@user.login}", :private => false)
    Event.create(:user_id => @user.id, :format => "add_book", :text => "Added @#{self.login} to bookmarks", :private => false)
  end
  
  #Bookmark search page
  def bookmark_search(tags)
    @bookmark = Bookmark.find_or_create_by_name(tags)
    self.bookmarks << @bookmark
    Event.create(:user_id => self.id, :format => "add_book", :text => "Added ##{tags} page to bookmars", :private => true)
  end
  
  #Request bookmark
  def request_bookmark(user)
    @user = User.find_by_login(user)
    Subscription.create(:user_id => self.id, :subscriber_id => @user.id)
    Event.create(:user_id => self.id, :format => "request", :text => "Sent request to @#{@user.login}", :private => true)
    Event.create(:user_id => @user.id, :format => "request", :text => "Received a request from @#{self.login}", :private => true)
  end
  
  #Remove bookmarked profile
  def delete_profile(user)
    @user = User.find_by_login(user)
    @sub = self.subscriptions.find_by_subscriber_id(@user.id)
    @sub.destroy
    Event.create(:user_id => self.id, :format => "rm_book", :text => "Removed bookmark of @#{@user.login}", :private => true)
    Event.create(:user_id => @user.id, :format => "rm_book", :text => "You have been removed from @#{self.login} bookmarks", :private => true)
  end
  
  #Remove bookmarked search page
  def delete_search(tag)
    @bookmark = Bookmark.find_by_name(tag)
    @bookmark.users.delete self

    Event.create(:user_id => self.id, :format => "rm_book", :text => "Removed bookmark of ##{tag}", :private => true)
  end
  
  #Pause/unpause subscription TO DELETE
  def pause_subscription(user)
    @user = User.find_by_login(user)
    @sub = self.subscriptions.find_by_subscriber_id(@user.id)
    @sub.update_attributes(:paused => !@sub.paused)
  end

  #Change default :id to login name, instead user_id
  def to_param
    login
  end
  
  def get_all_events(page)
    #Events from user
    #@tmp = self.events.find :all, :order => 'created_at DESC'
    
    #Messages from user's bookmarks
    #self.authorized_users.each do |s|
     # @tmp += s.events.find :all, :conditions => "format = 'msg'", :order => 'created_at DESC'
    #end
    
    return Event.search(self, { :per_page => 10, :page => page })
    
    #Tagged events from tag bookmarks - TODO
    
    #return @tmp.uniq.sort {|a,b| b.created_at <=> a.created_at}
  end
  
  def get_all_messages
    #Messages from user
    self.events.find :all, :conditions => "format = 'msg'", :order => 'created_at DESC'
  end
  
  protected
    
    def make_activation_code
        self.activation_code = self.class.make_token
    end


end
