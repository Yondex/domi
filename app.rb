#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def init_db
	@db = SQLite3::Database.new 'sor.db3'
	@db.results_as_hash = true
end

before do
 init_db
end

configure do
	init_db
		@db.execute 'CREATE TABLE IF NOT EXISTS post
		 (
	id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	create_date	DATE,
	content	TEXT
)'
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"
end

get '/new' do
	erb :new
end

post '/new' do
	text = params[:content]
 erb "You typing #{text}"
end