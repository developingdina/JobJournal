require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :homepage
  end

  get '/signup' do 
    erb :'users/signup'
  end

  post '/signup' do 
    user = User.new(username: params[:username], email: params[:email], password: params[:password])

    if user.save
      session[:id] = user.id
    else
      redirect "/signup"
    end
  end

end
