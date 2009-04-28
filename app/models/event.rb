class Event < ActiveRecord::Base
  has_and_belongs_to_many :groups
  belongs_to :user
  
  def self.search(user, options = {})
    find :all do
      paginate options 
      any do
        all do
          if user.subscriber_ids.include?(user_id)
            user_id 
            format == 'msg'
          end 
        end
        user_id == user.id
      end
      order_by created_at.desc
    end
  end
end
