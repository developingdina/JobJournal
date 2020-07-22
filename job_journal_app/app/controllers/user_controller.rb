class UserController < ApplicationController


    get '/signup' do 
        if logged_in?
            redirect "/posts"
        else
            erb :'users/signup'
        end
      end
    
    post '/signup' do 
        ##used validates_uniqueness_of to condense this logic
        @user = User.new(params)
        if  @user.save 
            session[:user_id] = @user.id 
            flash[:message] = "Welcome #{@user.username}! You were successfully logged in."	
            redirect "/posts"
        else
            flash.now[:errors] = "That username already exists, try again:"
             erb :'users/signup'
        end
    end

    get '/login' do 
        if logged_in?
            redirect "/posts"
        else
            erb :'users/login'
        end
    end

    post '/login' do 
        find_user
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/posts"
        #Took out elsif statement 
        else
            flash[:errors] = "Maybe you mistyped? Try again:"
            redirect "/login"
        end
    end

    get '/logout' do
        if logged_in?
            session.clear
        end
        flash[:message] = "See you next time!"
        redirect "/login"
    end

end