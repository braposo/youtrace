class Group < ActiveRecord::Base
  validates_presence_of :name, :message => "is required"
  validates_length_of :name, :minimum => 4, :allow_nil => true
  
  has_many :groups_users
  has_many :users, :through => :groups_users
  #has_and_belongs_to_many :traces 
  
  def is_owned_by?(user)
    self.groups_users.find_by_user_id user, :conditions => 'level = 2'
  end
  
  def owner
    @tmp = self.groups_users.find_by_level 2
    @tmp.user
  end
end
