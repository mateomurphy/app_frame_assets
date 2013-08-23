require 'dragonfly'

module AppFrameAssets
  module Config
    def self.setup(type, accessor)

      app = Dragonfly[type]
      app.configure_with(:rails)  
      app.configure_with(:imagemagick) if type == :images

      app.define_macro(ActiveRecord::Base, accessor)

      app.configure do |c|
        c.url_format = "/#{type}/:job/:basename.:format"
      end

      if Rails.env != 'test'
        app.datastore = Dragonfly::DataStorage::S3DataStore.new
        app.datastore.configure do |c|
          c.bucket_name = Settings.aws.bucket_name
          c.access_key_id = Settings.aws.access_key_id
          c.secret_access_key = Settings.aws.secret_access_key
        end 
      end
    end
  end
end