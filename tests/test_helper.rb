ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'minitest/color'
require 'rack/test'
require 'sequel'
require 'sinatra'

DB = Sequel.connect(
  adapter: 'postgres',
  database: 'vocational-test_test',
  host: 'testdb',
  user: 'unicorn',
  password: 'magic'
)

class Minitest::HooksSpec
  def around
    DB.transaction(rollback: :always, auto_savepoint: true) { super }
  end
end

require File.expand_path './app.rb'
