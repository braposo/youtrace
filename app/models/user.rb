require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  has_and_belongs_to_many :groups
  #has_and_belongs_to_many :traces
  #has_and_belongs_to_many :subscriptions, :class_name => "User", :join_table => "subscriptions", :foreign_key => "user_id", :association_foreign_key => "subscriber_id"
  
  has_many :subscriptions
  has_many :subscribers, :through => :subscriptions
  
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
  attr_accessible :login, :email, :name, :password, :password_confirmation


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
    
    self.subscriptions.find_by_subscriber_id(@user) ? true : false
  end
  
  #Check if current user is following :user
  def is_following?(user)
    if user.class != User
      @user = User.find_by_login(user)
    else
      @user = user
    end
    
     @user.subscriptions.find_by_subscriber_id(self) ? true : false
  end

  
  #Return list of authorized subscriptions
  def authorized_subscriptions
    @subs = self.subscriptions.find :all, :conditions => 'authorized = true'
    @subs.map!{ |s| User.find_by_id(s.subscriber_id) }
  end
  
  #Return list of authorized subscriptions
  def authorized_followers
    @subs = Subscription.find :all, :conditions => ['subscriber_id = ? AND authorized = true', self.id]
    @subs.map!{ |s| User.find_by_id(s.user_id) }
  end
  
  #Return list of pending requests
  def pending_requests
    @subs = Subscription.find :all, :conditions => ['subscriber_id = ? AND authorized = false', self.id]
    @subs.map!{ |s| User.find_by_id(s.user_id) }
  end
  
  #Return list of pending requests
  def pending_subscriptions
    @subs = self.subscriptions.find :all, :conditions => 'authorized = false'
    @subs.map!{ |s| User.find_by_id(s.subscriber_id) }
  end
  
  #Authorize follower
  def authorize_follower(user)
    @user = User.find_by_login(user)
    @sub = @user.subscriptions.find_by_subscriber_id self.id
    @sub.update_attributes(:authorized => true)
  end
  
  #Request subscription
  def request_subscription(user)
    @user = User.find_by_login(user)
    Subscription.create(:user_id => self.id, :subscriber_id => @user.id)
  end
  
  #Remove subscription
  def remove_subscription(user)
    @user = User.find_by_login(user)
    @sub = self.subscriptions.find_by_subscriber_id(@user.id)
    @sub.destroy
  end
  
  #Pause/unpause subscription
  def pause_subscription(user)
    @user = User.find_by_login(user)
    @sub = self.subscriptions.find_by_subscriber_id(@user.id)
    @sub.update_attributes(:paused => !@sub.paused)
  end

  #Change default :id to login name, instead user_id
  def to_param
    login
  end
  
  protected
    
    def make_activation_code
        self.activation_code = self.class.make_token
    end


end
