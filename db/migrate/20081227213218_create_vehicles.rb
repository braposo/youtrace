class CreateVehicles < ActiveRecord::Migration
  def self.up
    create_table :vehicles do |t|
      t.string :kind
      t.string :make
      t.string :model
      t.string :displace
      t.decimal :highway
      t.decimal :city
      t.decimal :combined

      t.timestamps
    end
  end

  def self.down
    drop_table :vehicles
  end
end
