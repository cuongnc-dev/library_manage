source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.0.1"
gem "puma", "~> 3.0"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "jquery-rails"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "bcrypt", "3.1.11"
gem "faker", "1.7.3"
gem "carrierwave", "1.0.0"
gem "mini_magick", "4.6.1"
gem "fog", "1.38.0"
gem "will_paginate", "3.1.5"
gem "bootstrap-will_paginate", "0.0.10"
gem "figaro"
gem "bootstrap-sass"
gem "config"
gem "axlsx_rails"
gem "ckeditor"
gem "bootstrap-datepicker-rails"
gem "date_validator", '~> 0.9.0'
gem "whenever", require: false
gem "delayed_job"
gem "delayed_job_active_record"
gem "redis"

group :development, :test do
  gem "sqlite3"
  gem "byebug", platform: :mri
end

group :production do
  gem "pg"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
