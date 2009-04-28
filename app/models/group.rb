class Group < ActiveRecord::Base
  validates_presence_of :name, :message => "is required"
  validates_length_of :name, :minimum => 4, :allow_nil => true
  
  has_many :groups_users
  has_many :users, :through => :groups_users
  has_and_belongs_to_many :events
  has_and_belongs_to_many :traces 
  
  def is_owned_by?(user)
    @tmp = self.groups_users.find_by_user_id user, :conditions => 'level = 2'
    !@tmp.nil?
  end
  
  def owner
    @tmp = self.groups_users.find_by_level 2
    @tmp.user
  end
  
  def get_all_events
    @tmp = self.events.find :all, :order => 'created_at DESC'
    
    # self.users.find(:all, :conditions => 'protect_updates = false').each do |u|
    #       u.events.find(:all, :order => 'created_at DESC').each do |e|
    #         @tmp.insert(0,e) if !@tmp.include? e
    #       end
    #     end
    
    return @tmp.sort {|a,b| b.created_at <=> a.created_at}
  end
end
