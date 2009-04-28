class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :user_id
      t.integer :group_id
      t.string :format, :default => "msg"
      t.text :text
      t.boolean :private, :default => false
      t.integer :receiver_id, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
