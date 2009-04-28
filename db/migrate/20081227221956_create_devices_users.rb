class CreateDevicesUsers < ActiveRecord::Migration
  def self.up
    create_table :devices_users, :id => false do |t|
      t.integer :device_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :devices_users
  end
end
