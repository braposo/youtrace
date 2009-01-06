class Trace < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :groups
  belongs_to :vehicle
  belongs_to :device
  
  after_create :generate_events
  
  private
  def generate_events
    if self.group_ids.empty?
      Event.create(:user_id => self.user_id, :format => "new_trace", :text => "Added a new trace", :private => false)
    else
      Event.create(:user_id => self.user_id, :group_ids => self.group_ids, :format => "new_trace", :text => "Added a new trace", :private => false)
    end
  end
end
