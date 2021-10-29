require 'bundler'
require 'sinatra'
require 'sequel'

Bundler.require

# Create a connection and leave it as a global object in our project
DB = Sequel.connect(
  adapter: 'postgres',
  database: 'vocational-test',
  host: 'db',
  user: 'unicorn',
  password: 'magic'
)

# Require and run the main app
root = ::File.dirname(__FILE__)
require ::File.join(root, 'app')
run App.new
