# frozen_string_literal: true

# ruby=ruby-3.0.2
# ruby-gemset=triviacrack-web

source "https://rubygems.org"

ruby "3.0.2"

gem "rails", "6.1.4.1"
gem "thin", "1.8.1"

gem "pg", "1.2.3"
gem "rails-bigint-primarykey", "2.0.0"

gem "sass-rails", "6.0.0"
gem "uglifier", "4.2.0"

gem "devise", "4.8.0"

gem "jbuilder", "2.11.2"
gem "jquery-rails", "4.4.0"
gem "turbolinks", "5.2.1"

gem "redis", "4.4.0"
gem "resque", "2.1.0"
gem "resque-scheduler", "4.4.0"

gem "pundit", "2.1.1"

gem "semantic-ui-sass", "2.4.4.0"
gem "triviacrack", "0.6.0"

gem "resque-web", "0.0.12", require: "resque_web"

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem "sdoc", "2.2.0", group: :doc

group :development do
  gem "web-console", "4.1.0"
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug"
  gem "factory_bot", "6.2.0", require: false
  gem "faker", "2.19.0", require: false
  gem "fuubar", "2.5.1"
  gem "rails-controller-testing"
  gem "rspec-activejob", "0.6.1", require: false
  gem "rspec-its", "1.3.0", require: false
  gem "rspec-rails", "5.0.2"
  gem "shoulda-matchers", "5.0.0"
  gem "simplecov", "0.21.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"

  gem "rubocop"
  gem "rubocop-rails", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rspec", require: false
end
