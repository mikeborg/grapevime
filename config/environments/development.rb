ENV['TWITTER_CONSUMER_KEY'] = "bRaPqfzDDTWIixQ5238lw"
ENV['TWITTER_CONSUMER_SECRET'] = "tuk4Asn2m8Stp6b3vnns1mayDmX1poTOoNLcFruyjw"
ENV['TWITTER_OAUTH_TOKEN'] = "274188681-14Lh7t7IEZd1iWAt1Uur8PnyyYz1RnTO6Yd0nhqo"
ENV['TWITTER_OAUTH_TOKEN_SECRET'] = "M9k3DYz8RYvrh8yHmk3UHClsZLpLkTTxMFsg6yYyC0"

Grapevime::Application.configure do
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

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
end
