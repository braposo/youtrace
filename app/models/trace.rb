class Trace < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :groups
  belongs_to :vehicle
  belongs_to :device
  
  after_create :generate_events
  
  validates_presence_of     :name
  validates_length_of       :name,    :within => 6..40
  validates_uniqueness_of   :name
  
  has_attached_file :file
  validates_attachment_presence :file
  
  acts_as_taggable_on :tags
  
  def self.search(query = '', options = {})
    find :all do
      paginate options
      any do
        name.contains? query
        description.contains? query
        tags.name.contains? query
      end
      order_by created_at.desc
    end
  end
  
  private
  def generate_events
    if self.group_ids.empty?
      Event.create(:user_id => self.user_id, :format => "new_trace", :text => "Added a new trace", :private => false)
    else
      Event.create(:user_id => self.user_id, :group_ids => self.group_ids, :format => "new_trace", :text => "Added a new trace", :private => false)
    end
  end
end
