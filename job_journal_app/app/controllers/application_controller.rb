require './config/environment'
require 'sinatra/flash'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    register Sinatra::Flash 
    set :session_secret, ENV['SESSION_PASSWORD']
  end

  get '/' do
    erb :homepage
  end

  

  helpers do

    def current_user?
      User.find_by(id: session[:user_id])
    end

    def logged_in?
      !!current_user?
    end
    
    ##created new helper that finds post by post by id in current users collection
    def post_by_user
      @post = current_user?.posts.find_by_id(params[:id])
      if @post 
        @post 
      else
        flash[:errors] = "That post does not exist!"
        redirect "/posts"
      end
    end

    def find_user
      @user = User.find_by(username: params[:username])
    end

  end

end
