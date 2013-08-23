class ZipAttachment < AssetAttachment
  attr_protected :id
  
  belongs_to :zip_file, :foreign_key => :asset_file_id
  accepts_nested_attributes_for :zip_file  
  
  delegate :file, :to => :zip_file  
    
  after_initialize do
    self.zip_file ||= ZipFile.new
  end
  
end