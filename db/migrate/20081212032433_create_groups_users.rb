class CreateGroupsUsers < ActiveRecord::Migration
  def self.up
    create_table :groups_users, :force => true, :id => false do |t|
      t.column :group_id, :integer
      t.column :user_id, :integer
      t.column :role, :integer, :default => 0
    end
    
    add_index :groups_users, [:group_id, :user_id]
  end

  def self.down
    drop_table :groups_users
  end
end
