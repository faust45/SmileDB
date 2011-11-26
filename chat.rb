require './db'
require './index'
require 'sinatra'
require 'json'


# API
db = DB.new('chat')

set :views, 'views'
set :public, File.dirname(__FILE__)
enable :static
enable :sessions


get "/login" do
  erb :login
end

post "/login" do
  session[:login] = params[:login]
  redirect "/"
end

get "/" do
  session[:last_id] = nil

  if current_user == nil
    redirect '/login'
  end

  erb :index
end

post "/send_msg" do
  db.add({:msg => params[:msg], :from => current_user})
  "ok"
end

get "/feed" do
  coll = db.where(:id.gt session[:last_id].to_i)

  if coll.length != 0
    session[:last_id] = coll.last[:id]
  end

  coll.to_json
end

helpers do
  def current_user
    p session
    if session[:login] != nil
      session[:login] 
    end
  end
end
