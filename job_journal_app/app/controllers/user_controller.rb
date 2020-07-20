class UserController < ApplicationController


    get '/signup' do 
        if logged_in?
            redirect "/posts"
        else
            erb :'users/signup'
        end
      end
    
    post '/signup' do 
        if User.find_by(username: params[:username])
            flash[:errors] = "Sorry that username already exists! Try again:"
            redirect "/signup"
        else
            user = User.new(username: params[:username], email: params[:email], password: params[:password])
    
            if user.save 
                session[:user_id] = user.id 
            else
                flash[:errors] = "Sorry about that. It's not you, its' us. Try again"
                redirect "/signup"
            end
        flash[:message] = "Welcome #{user.username}! You were successfully logged in."
        redirect "/posts"
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
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:message] = "Nice to see you again #{user.username}! You were successfully logged in."
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