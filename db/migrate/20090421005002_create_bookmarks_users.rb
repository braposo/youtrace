class CreateBookmarksUsers < ActiveRecord::Migration
  def self.up
     create_table :bookmarks_users, :id => false do |t|
        t.integer :bookmark_id
        t.integer :user_id
      end
  end

  def self.down
    drop_table :bookmarks_users
  end
end
