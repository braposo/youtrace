class ChangeSexToGender < ActiveRecord::Migration
  def self.up
    rename_column :users, :sex, :gender
    change_column :users, :gender, :string
  end

  def self.down
    rename_column :users, :gender, :sex
    change_column :users, :sex, :integer
  end
end
