source "https://rubygems.org"

git_source(:github) do |repo_name|
 repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
 "https://github.com/#{repo_name}.git"
end

 gem "rails", "~> 5.1.4"
 gem "sqlite3"
 gem "puma", "~> 3.7"
 gem "bootstrap-sass", "3.3.7"
 gem "sass-rails", "~> 5.0"
 gem "uglifier", ">= 1.3.0"
 gem "coffee-rails", "~> 4.2"
 gem "turbolinks", "~> 5"
 gem "jbuilder", "~> 2.5"

group :development, :test do
 gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
 gem "capybara", "~> 2.13"
 gem "rspec"
 gem "rspec-rails"
 gem "rspec-collection_matchers"
 gem "factory_bot_rails"
 gem "better_errors"
 gem "guard-rspec", require: false
 gem "database_cleaner"
 gem "brakeman", require: false
 gem "jshint"
 gem "i18n-js"
 gem "bundler-audit"
 gem "rubocop", require: false
 gem "rubocop-checkstyle_formatter", require: false
 gem "eslint-rails", git: "https://github.com/octoberstorm/eslint-rails", require: false
 gem "scss_lint_reporter_checkstyle", require: false
 gem "rails_best_practices"
 gem "reek"
 gem "railroady"
 gem "carrierwave", "1.2.2"
 gem "mini_magick", "4.7.0"
 gem "will_paginate", "3.1.6"
 gem "bootstrap-will_paginate", "1.0.0"
 gem "autoprefixer-rails"
 gem "faker", "1.7.3"
 gem "rails-controller-testing"
 gem "bcrypt", "3.1.11"
 gem "config"
 gem "jquery-rails"
 gem "jquery-turbolinks"
end

group :development do
 gem "web-console", ">= 3.3.0"
 gem "listen", ">= 3.0.5", "< 3.2"
 gem "spring"
 gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
 gem "simplecov", require: false
 gem "simplecov-rcov", require: false
 gem "simplecov-json"
 gem "shoulda-matchers"
 gem "minitest", group: :test
 gem "minitest-reporters", group: :test
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
