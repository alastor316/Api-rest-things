source 'https://rubygems.org'

# test api-json https://httpie.org/#installation


git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.1'
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
 gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'cancancan', '~> 1.10'
gem 'bcrypt', '~> 3.1.7'

# gem 'doorkeeper'
gem 'jquery-rails'
gem 'sass-rails', '~> 5.0.4'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
gem 'bootstrap-sass', '~> 3.3.7'
gem 'font-awesome-rails'

gem 'http'
#Usar Postgrest
gem 'swagger-docs'

gem 'swagger_ui_engine'


#Correr Jobs
gem "sidekiq"

#Calendariza los jobs de sidekiq
gem 'whenever', :require => false

gem 'sidekiq-client-cli' #to run sidekiq with whenever


#Disallow processes from trying to run on top of each other when they share resources
#gem 'lockrun', '~> 0.0.1' 
gem 'sidekiq-lock'
#Base de datos para Jobs
gem 'redis-rails'

gem 'fast_inserter'

gem 'rack-cors'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.5'
  gem "better_errors"
  gem 'web-console', '>= 3.3.0'
  gem 'bullet'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

#Ver los logs de Redis
gem 'redis-browser'
end


group :test do
  gem 'sqlite3'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'faker'
  gem 'database_cleaner'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
