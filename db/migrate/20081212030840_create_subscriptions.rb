class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table "subscriptions", :force => true do |t|
      t.integer :user_id
      t.integer :subscriber_id
      t.boolean :authorized, :default => false
      t.boolean :paused, :default => false
    end
    
    add_index :subscriptions, [:user_id, :subscriber_id, :authorized]
  end

  def self.down
    drop_table "subscriptions"
  end
end
