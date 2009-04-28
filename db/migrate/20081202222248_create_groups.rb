class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :name
      t.text :description
      t.string :photo
      t.integer :privacy,    :default => 0
      t.decimal :traced,     :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
