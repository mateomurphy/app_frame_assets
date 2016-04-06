require 'acts_as_list'

module AppFrameAssets
  class Engine < ::Rails::Engine
    initializer "app_frame_assets.setup_dragonfly" do |app|
      Config.setup :images, :image_accessor
      Config.setup :media, :media_accessor

      app.middleware.insert_after 'Rack::Lock', 'Dragonfly::Middleware', :images
    end
  end
end
