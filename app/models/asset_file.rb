class AssetFile < ActiveRecord::Base
  attr_protected :id
  
  belongs_to :account
  
  scope :with_query, lambda { |s| where('name LIKE ? OR file_name LIKE ?', "%#{s}%", "%#{s}%") }
  
  def datastore
    return nil unless file
    
    @datastore ||= file.app.datastore
  end
  
  def object_url(opts = {})
    return nil unless file
    
    expires = opts[:expires] || 1.week.from_now
    datastore.storage.get_object_http_url(datastore.bucket_name, file_uid, expires, opts)
  end  
  
  def safe_file_name
    ActiveSupport::Inflector.transliterate(file_name)
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
