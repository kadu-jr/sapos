source 'https://rubygems.org'

# The following line is necessary to allow RVM choosing the correct ruby version. RVM 2.0 will probably be able to interpret the "~>" symbol and we will be able to safely remove the "#ruby=2.4" line.
#ruby=2.4
ruby '2.3.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.1.4'

gem 'rubyzip', '>=1.2.1'

# Use sqlite3 as the database for Active Record
# gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '>= 4.0.4'
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

gem "rails-erd"
gem "kaminari"
#gem "schema_plus"

gem 'cancancan'
gem "devise"
gem "paper_trail"

gem 'sql-parser'

# Iconography
gem 'font-awesome-rails'

# Prawn to PDF
gem 'prawn'
gem 'prawn-table' 
gem 'prawn_rails'
gem 'odf-report'
gem 'clamsy', :git => 'https://github.com/gems-uff/clamsy.git', :branch => 'rails5'

# Redcarpet for Readme MarkDown (or README.md)
gem 'redcarpet' 

# Active scaffold support for Rails 3
gem 'active_scaffold', :git => 'https://github.com/activescaffold/active_scaffold.git'
gem 'active_scaffold_duplicate', '>= 1.1.0'
gem 'recordselect'

#Date Validation Plugin
gem 'validates_timeliness'

# Menu
gem 'simple-navigation'

# Notification
gem 'rufus-scheduler'
gem 'codemirror-rails'

# Image
gem 'carrierwave'
gem 'carrierwave-activerecord', :git => 'https://github.com/gems-uff/carrierwave-activerecord.git', :branch => 'rails5'


group :development, :test do
  gem 'sqlite3'
  gem 'awesome_print'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'webrick'
  gem 'binding_of_caller'
  gem 'better_errors'
  gem 'spring'
  gem 'byebug'
  gem 'unicorn'
end

group :production, :staging do
  gem 'mysql2'
  gem 'exception_notification', '2.6.1', :require => 'exception_notifier'
end

gem 'json'
gem 'rdoc'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# HTML to PDF Engine
gem 'wkhtmltopdf-binary'

# HTML to PDF Converter. Uses wkhtmltopdf
 gem 'pdfkit'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
