Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { :host => 'localhost:5000' }

  Rails.application.routes.default_url_options[:host] = 'localhost:5000'

  config.action_mailer.smtp_settings = {
    address: ENV["EMAIL_HOST"],
    port: 587,
    domain: ENV["EMAIL_DOMAIN"],
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: ENV["EMAIL_USERNAME"],
    password: ENV["EMAIL_PASSWORD"]
  }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  ENV["REDIS_URL"] = 'redis://localhost:6379'
  ENV["DEVISE_SECRET_KEY"] = 'c707148dbea1a3ce1d0cb157a3c5a9a2cc2321bd7f03ba4691e638f0dfb1ab69756e1a9d5069c4dfb7adb76cde62adde8caf77e74e8836da045787f14da38c3a'

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  config.active_job.queue_adapter = :resque
end
