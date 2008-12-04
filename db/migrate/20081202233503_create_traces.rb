class CreateTraces < ActiveRecord::Migration
  def self.up
    create_table :traces do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :traces
  end
end
