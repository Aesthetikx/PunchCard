require 'sinatra'

class App < Sinatra::Base

  set :database, { adapter: 'sqlite3', database: 'punch.sqlite3' }
  set :public_folder, File.expand_path('../public', __FILE__)

  get '/' do
    File.read(File.expand_path('index.html', settings.public_folder))
  end

  get '/punches' do
    PunchCard::Punch.all.where(params).to_json
  end

  post '/punches' do
    PunchCard::Punch.create(params).save!
  end
end

App.run!

