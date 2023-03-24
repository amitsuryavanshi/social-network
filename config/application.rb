# frozen_string_literal: true

require_relative 'boot'

# require "rails"
# Pick the frameworks you want:
require 'active_model_serializers' # required to avoid active_model_serializers/railtie
require "active_model/railtie"
# require "active_job/railtie"
# require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
require 'active_graph/railtie'

require 'neo4j_ruby_driver'
#require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OrgApi
  class Application < Rails::Application

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.autoloader = :zeitwerk

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_once_paths << "#{root}/lib"
    config.eager_load_paths << "#{root}/lib"

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    # config.active_record.whitelist_attributes = false

    # Delete uploaded files for each request upon completion
    #config.middleware.use Rack::TempfileReaper

    # Proxy Eightfold API
    #config.middleware.use Middlewares::EightfoldMiddleware

    # Rack middleware used for jsonapi-suite filters with same keys
    #config.middleware.use Middlewares::QueryStringMiddleware

    # Do not interpret jsonapi payloads with certain extensions
    #config.middleware.use Middlewares::JsonApiNonParsableMiddleware  

    # Disable Rails's static asset server (Apache or nginx will already do this)
    config.public_file_server.enabled = false

    config.generators do |g|
      #g.test_framework :rspec, fixture: false
      g.orm :active_graph
    end

    #config.neo4j.id_property = :neo_id
    config.neo4j.include_root_in_json = false
    config.neo4j.timestamp_type = Time
    config.neo4j.fail_on_pending_migrations = false

    config.notify_airbrake = false

    config.allow_concurrency = true

    config.mailer_from = '"Test" <no-reply@test.com>'
    config.mailer_audit_to = 'support@test.com'
    config.mailer_audit_cc = 'test@test.com'
  end
end
