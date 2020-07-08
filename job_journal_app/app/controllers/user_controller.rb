class UserController < ApplicationController


    get '/signup' do 
        if logged_in?
            redirect "/posts"
        else
            erb :'users/signup'
        end
      end
    
    post '/signup' do 
        user = User.new(username: params[:username], email: params[:email], password: params[:password])
    
            if user.save
                session[:user_id] = user.id 
            else
                redirect "/signup"
            end
        redirect "/posts"
    end

    get '/login' do 
        if logged_in?
            redirect "/posts"
        else
            erb :'users/login'
        end
    end
#########################
    post '/login' do 
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/posts"
        elsif !(user && user.authenticate(params[:password]))
            redirect "/login"
        end
    end
#########################
    get '/logout' do
        if logged_in?
            session.clear
        end
            redirect "/login"
    end

end