source "https://rubygems.org"

ruby "3.3.5"
gem "typeprof", "0.21.11"
# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "7.2.2"
gem "active_storage_validations", "0.9.8"
gem "ostruct", "0.6.1"
gem "bcrypt", "3.1.20"
gem "pg", "1.5.9"
gem "faker", "3.5.1"
gem "will_paginate", "4.0.1"
gem "will_paginate-bootstrap-style", "0.3.0"
gem "bootstrap-sass", "3.4.1"
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails", "3.4.2"
# Use sqlite3 as the database for Active Record
gem "sqlite3", "1.6.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "6.5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails", "1.1.5"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails", "1.4.0"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails", "1.2.1"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder", "2.13.0"
# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", "1.2024.2", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", "1.18.4", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", "1.9.2", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", "6.2.2", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console", "4.2.0"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara", "3.38.0"
  gem "selenium-webdriver", "4.8.3"
  gem "guard", "2.19.0"
  gem "rails-controller-testing", "1.0.5"
end
