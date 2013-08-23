class ImageAttachment < AssetAttachment
  attr_protected :id
  
  belongs_to :image_file, :foreign_key => :asset_file_id
  accepts_nested_attributes_for :image_file  
  
  delegate :file, :to => :image_file  
    
  after_initialize do
    self.image_file ||= ImageFile.new
  end
  
end