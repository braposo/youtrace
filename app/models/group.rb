class Group < ActiveRecord::Base
  validates_presence_of :name, :message => "is required"
  validates_length_of :name, :minimum => 4, :allow_nil => true
  
  has_and_belongs_to_many :accounts
  has_and_belongs_to_many :traces
end
