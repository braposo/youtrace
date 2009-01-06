class CreateGroupsTraces < ActiveRecord::Migration
  def self.up
    create_table :groups_traces, :id => false do |t|
      t.integer :group_id
      t.integer :trace_id
    end
  end

  def self.down
    drop_table :groups_traces
  end
end
