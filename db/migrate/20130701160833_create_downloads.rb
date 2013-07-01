class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.integer :download_count
      t.integer :allowed_downloads
      t.datetime :expires_at
      t.string :short_url

      t.timestamps
    end
  end
end
