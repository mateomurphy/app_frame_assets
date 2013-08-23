$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "app_frame_assets/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "app_frame_assets"
  s.version     = AppFrameAssets::VERSION
  s.authors     = ["Mateo Murphy"]
  s.email       = ["mateo.murphy@gmail.com"]
  s.summary     = "Assets for AppFrame"
  s.description = "Adds an asset system to app frame"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.14"
  s.add_dependency "dragonfly", "~> 0.9.15"
  s.add_dependency "acts_as_list"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "mysql2"
end
