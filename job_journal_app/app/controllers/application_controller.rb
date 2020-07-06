require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
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
      session[:user_id] = user.id 
    else
      redirect "/signup"
    end
    
  end


  helpers do

    def current_user?(session)
      User.find_by(id: session[:user_id])
      binding.pry

    end

    def logged_in?(session)
      !!current_user
    end

  end

end
