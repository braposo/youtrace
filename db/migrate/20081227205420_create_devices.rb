class CreateDevices < ActiveRecord::Migration
  def self.up
    create_table :devices do |t|
      t.string :brand
      t.string :model
      t.string :kind

      t.timestamps
    end
  end

  def self.down
    drop_table :devices
  end
end
