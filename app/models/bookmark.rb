class Bookmark < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  validates_uniqueness_of :name, :message => "must be unique"
end
