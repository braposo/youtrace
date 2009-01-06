class CreateUsersVehicles < ActiveRecord::Migration
  def self.up
    create_table :users_vehicles, :id => false do |t|
        t.integer :user_id
        t.integer :vehicle_id
    end
  end

  def self.down
    drop_table :users_vehicles
  end
end
