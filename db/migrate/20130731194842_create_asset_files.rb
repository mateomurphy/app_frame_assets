class CreateAssetFiles < ActiveRecord::Migration
  def change
    create_table :asset_files do |t|
      t.string   "type"
      t.string   "name"
      t.text     "description"
      t.string   "file_uid"
      t.string   "file_mime_type"
      t.string   "file_name"
      t.string   "file_ext"
      t.integer  "file_size"
      t.integer  "file_width"
      t.integer  "file_height"
      t.string   "source_url"
      t.integer  "account_id"
      t.timestamps
    end
  end
end
