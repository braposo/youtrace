class Subscription < ActiveRecord::Base
  validates_presence_of :user_id
  
  belongs_to :user
  belongs_to :subscriber, :class_name => "User", :foreign_key => "subscriber_id"
end
