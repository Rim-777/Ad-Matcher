source 'https://rubygems.org'
ruby '2.4.2'

gem 'rack', '~> 1.6.0'
gem 'grape', '~> 0.17.0'
gem 'puma'
gem 'activerecord', '~> 5.0.2', require: 'active_record'
gem 'otr-activerecord', '~> 1.2.1'
gem 'pg', '~> 0.18'
gem 'grape-swagger', '~> 0.25.2'
gem 'typhoeus'

group :development, :test do
  gem 'rake'
  gem 'grape-cli'
  gem 'rspec'
  gem 'rspec-grape'
end

group :test do
  gem 'factory_bot'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
end
