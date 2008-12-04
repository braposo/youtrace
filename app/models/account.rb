class Account < ActiveRecord::Base
  validates_presence_of :username, :message => "is required"
  validates_presence_of :email, :message => "is required"
  validates_presence_of :password, :message => "is required"
  validates_length_of :password, :within => 6..12, :allow_nil => true
  validates_numericality_of :status, :equal_to => 0
  
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :traces
end
