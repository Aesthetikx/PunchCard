require 'sinatra'
require 'sinatra/activerecord'

require 'punch_card/punch'
require 'punch_card/version'

set :database, {adapter: "sqlite3", database: "punch.sqlite3"}
