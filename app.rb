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
	@results = @db.execute ('select * from post order by id desc')
	end

get '/new' do
	erb :new
end

post '/new' do
	text = params[:content]
	if text.length <=0
		@error = "typing text"
		return erb :new
	end
	  @db.execute("INSERT INTO post ( create_date, content) VALUES ( datetime(), ? )", [text])
 erb "You typing #{text}"
end
