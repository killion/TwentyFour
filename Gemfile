source 'https://rubygems.org'
ruby "2.0.0"

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'devise'                # User logins
gem 'bootstrap-sass'        # Bootstrap gem
gem 'font-awesome-rails'    # Use fonts instead of icons in Bootstrap

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use puma as the app server
gem 'puma'

gem 'newrelic_rpm'          # Application and server monitoring

# Gems for working with Viator
gem 'faraday'
gem 'multi_json'
gem 'rash'
gem 'hashie'
gem 'geocoder'

gem 'nearest_time_zone'     # Get the timezone for specific locations
gem 'stamp'                 # Better date formatting

group :production do
  gem 'rails_12factor'      # Gem for logging to stdout and serving assets
end

group :development, :test do
  gem "rspec-rails", "~> 2"
  gem "factory_girl_rails"
  gem "spork"
  gem "letter_opener"   # Show emails in a new browser window
  gem "bullet"          # Show database queries that should be eager loaded
end

group :development do
  gem "debugger"
  gem 'quiet_assets'
end
