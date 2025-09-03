# config/initializers/action_cable_patch.rb
# Patch for Rails 8 removing allowed_request_origins

if Rails.env.production?
  ActiveSupport.on_load(:action_cable) do
    config = Rails.application.config.action_cable
    if config.respond_to?(:allowed_request_origins=)
      # Reset it so Puma won’t crash
      config.allowed_request_origins = nil
    end
  end
end
