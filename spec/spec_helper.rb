ENV['RACK_ENV'] ||= "test"

require 'active-record-atomic'
require 'rspec'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.configure do |c|
  c.after :each do
    DatabaseCleaner.clean
  end
end

tempfile = Tempfile.new ["atomic", "test"]

ActiveRecord::Base.configurations["test"] = { 'adapter' => 'sqlite3', 'database' => tempfile.path, 'pool' => 20 }
ActiveRecord::Base.establish_connection(:test)
ActiveRecord::Base.connection.create_table :posts do |t|
  t.string :title
  t.integer :views, :null => false, :default => 0
end

class Post < ActiveRecord::Base
end
