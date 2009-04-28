class CreateTraces < ActiveRecord::Migration
  def self.up
    create_table :traces do |t|
      t.integer :user_id
      t.integer :device_id
      t.integer :vehicle_id
      t.string :name
      t.text :description
      t.string :kind,    :default => 'Road'
      t.decimal :length,  :default => 0
      t.string :file
      t.integer :status,  :default => 0
      t.integer :privacy, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :traces
  end
end
