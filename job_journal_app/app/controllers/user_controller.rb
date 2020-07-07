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
        elsif !(user && user.authenticate(params[:password]))
            redirect "/signup"
        else
            redirect "/login"
        end
        redirect "/posts"
    end
#########################
    get '/logout' do
        if logged_in?
            session.clear
        end
            redirect "/login"
    end

end