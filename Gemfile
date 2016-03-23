source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.0.0.beta2'
# Use postgres as the database for Active Record
gem 'pg', '~> 0.18.4'
# Use Unicorn as the app server
gem 'unicorn'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Use Capistrano for deployment
gem 'capistrano-rails', group: :development
# Authentication solution
gem 'devise', '4.0.0.rc1'
# Temaplte engine
gem 'slim'
# Admin panel
gem 'activeadmin', github: 'activeadmin'
gem 'formtastic', github: 'justinfrench/formtastic'
# Authourization solution
gem 'cancancan', '~> 1.13', '>= 1.13.1'
gem 'sinatra', git: 'https://github.com/sinatra/sinatra.git'
gem 'activemodel-serializers-xml', github: 'rails/activemodel-serializers-xml'
gem 'draper', github: 'audionerd/draper', branch: 'rails5'
gem 'kaminari',   github: 'amatsuda/kaminari', branch: '0-17-stable'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry'
  gem 'mailcatcher'
  gem 'rspec-rails', '~> 3.0'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'capistrano3-unicorn'
  gem 'capistrano-rvm'
end

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap'
end

