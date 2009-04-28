class AddAttachmentsFileToTraces < ActiveRecord::Migration
  def self.up
    add_column :traces, :file_file_name, :string
    add_column :traces, :file_content_type, :string
    add_column :traces, :file_file_size, :integer
    add_column :traces, :file_updated_at, :datetime
  end

  def self.down
    remove_column :traces, :file_file_name
    remove_column :traces, :file_content_type
    remove_column :traces, :file_file_size
    remove_column :traces, :file_updated_at
  end
end
