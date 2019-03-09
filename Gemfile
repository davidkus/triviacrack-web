#ruby=ruby-2.4.1
#ruby-gemset=triviacrack-web

ruby "2.4.1"

source 'https://rubygems.org'

gem 'rails', '5.1.6.1'
gem 'thin', '1.7.2'

gem 'pg', '0.21.0'
gem 'rails-bigint-primarykey', '2.0.0'

gem 'sass-rails', '5.0.7'
gem 'uglifier', '4.1.5'

gem 'devise', '4.4.1'

gem 'jquery-rails', '4.3.1'
gem 'turbolinks', '5.1.0'
gem 'jbuilder', '2.7.0'

gem 'resque', '1.27.4'
gem 'resque-scheduler', '4.3.1'
gem 'redis', '< 4'

gem 'pundit', '1.1.0'

gem 'triviacrack', github: 'davidkus/triviacrack'
gem 'semantic-ui-sass', '2.2.14'

gem 'resque-web', '0.0.12', require: 'resque_web'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deploymentb
# gem 'capistrano-rails', group: :development

gem 'sdoc', '1.0.0.rc3', group: :doc

group :development do
  gem 'web-console', '3.5.1'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails', '3.7.2'
  gem 'rails-controller-testing'
  gem 'rspec-its', '1.2.0', require: false
  gem 'factory_bot', '4.8.2', require: false
  gem 'shoulda-matchers', '3.1.2'
  gem 'faker', '1.8.7', require: false
  gem 'rspec-activejob', '0.6.1', require: false
  gem 'fuubar', '2.3.1'
  gem 'simplecov', '0.15.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
