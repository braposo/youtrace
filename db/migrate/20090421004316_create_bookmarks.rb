class CreateBookmarks < ActiveRecord::Migration
  def self.up
    create_table :bookmarks do |t|
      t.column 'name', :string
      t.column 'tags', :string
      t.timestamps
    end
  end

  def self.down
    drop_table :bookmarks
  end
end
