class CreateEventsGroups < ActiveRecord::Migration
  def self.up
    create_table :events_groups, :id => false do |t|
      t.integer :event_id
      t.integer :group_id
    end
    
    remove_column :events, :group_id
  end

  def self.down
    drop_table :events_groups
    add_column :events, :group_id, :integer
  end
end
