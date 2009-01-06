class Vehicle < ActiveRecord::Base
  has_many :traces
  has_and_belongs_to_many :users
end
