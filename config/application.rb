require_relative "boot"
require "rails/all"
require 'base64'
require 'sprockets/railtie'

require_relative '../lib/middlewares/custom_rate_limit'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
module DemoBlog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    # config.middleware.use CustomRateLimit
    # config.middleware.use Rack::Attack
    # config.middleware.use Rack::RubyProf, path: './tmp/profile'
    config.assets.initialize_on_precompile = false
  end
end
