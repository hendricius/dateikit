class AddFilenameToDownload < ActiveRecord::Migration
  def change
    add_column :downloads, :filename, :string
  end
end
