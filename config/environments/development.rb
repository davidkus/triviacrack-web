Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.active_record.encryption.primary_key = "QJz0kshoMKpEeNiPjCdxom0u53CFkx8V"
  config.active_record.encryption.deterministic_key = "NQ6k55EaLeUqGHYPY5r2MuOdXi4KJngI"
  config.active_record.encryption.key_derivation_salt = "Ia6NmpyJddFn2k4Er1KHxW2OpDEQbqrd"

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
  config.action_mailer.default_url_options = { host: "localhost:3000" }

  Rails.application.routes.default_url_options[:host] = "localhost:3000"

  config.action_mailer.delivery_method = :letter_opener

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

  config.active_storage.service = :local

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  config.active_job.queue_adapter = :good_job
  config.good_job.execution_mode = :async
end
