class MediaFile < AssetFile
  attr_protected :id
  
  media_accessor :file
end