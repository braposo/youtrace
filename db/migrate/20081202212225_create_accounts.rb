class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :username
      t.string :password
      t.string :email
      t.integer :status
      t.string :code

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
