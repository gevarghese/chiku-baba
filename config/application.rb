require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChikuBaba
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Load environment-specific .env file
    Dotenv::Rails.load(".#{Rails.env}.env") if File.exist?(".#{Rails.env}.env")
    
    # Also load the main .env for shared variables
    Dotenv::Rails.load if File.exist?('.env')    



    # Don't care if the mailer can't send.
    #config.action_mailer.raise_delivery_errors = false

    # Make template changes take effect immediately.
    config.action_mailer.perform_caching = false
    

  # Configure Action Mailer to use SMTP
    config.action_mailer.delivery_method = :smtp
    
    # Set up SMTP settings for Zoho
    config.action_mailer.smtp_settings = {
      address:              'smtp.zoho.in',
      port:                 465,
      domain:               ENV['ZOHO_DOMAIN'],
      user_name:            ENV['ZOHO_EMAIL'],
      password:             ENV['ZOHO_PASSWORD'],
      authentication:       :plain,
      enable_starttls_auto: true,
      tls:                  true # Set to false if using port 465 with SSL
    }
      
    
    
    # Ensure emails are delivered
    config.action_mailer.perform_deliveries = true
    
    # Raise delivery errors for debugging
    config.action_mailer.raise_delivery_errors = true  
  end
end
