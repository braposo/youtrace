class CreateTraces < ActiveRecord::Migration
  def self.up
    create_table :traces do |t|
      t.string :name
      t.integer :type,    :default => 0
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
