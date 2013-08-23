class AssetFile < ActiveRecord::Base
  attr_protected :id
  
  belongs_to :account
  
  def datastore
    return nil unless file
    
    @datastore ||= file.app.datastore
  end
  
  def object_url(opts = {})
    expires = opts[:expires] || 1.week.from_now
    datastore.storage.get_object_http_url(datastore.bucket_name, file_uid, expires, opts)
  end  
  
  def to_s
    name.present? ? name : file_name
  end
  
  def to_token_hash
    { :id => id, :text => to_s }
  end
  
  def self.class_for_file(filename)
    case File.extname(filename).downcase
    when ".mp3", ".wav", ".aif", ".aiff" 
      klass = AudioFile
    when ".zip"
      klass = ZipFile
    when ".jpg", ".gif", ".png", ".jpeg"
      klass = ImageFile
    else
      klass = MediaFile
    end
  end  
  
  def self.create_from_s3(data, attrs = {})
    klass = class_for_file(data['name'])
    attrs[:file_uid] = data['key']
    attrs[:file_name] = data['name']
    attrs[:file_size] = data['size']
    
    klass.create(attrs)
  end  
  
end
