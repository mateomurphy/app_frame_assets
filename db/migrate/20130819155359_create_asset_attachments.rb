class CreateAssetAttachments < ActiveRecord::Migration
  def change
    create_table :asset_attachments do |t|
      t.string :type
      t.integer :asset_file_id
      t.string :attached_to_type
      t.integer :attached_to_id
      t.integer :position

      t.timestamps
    end
  end
end
