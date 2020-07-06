class UserController < ApplicationController


    get '/signup' do 
        erb :'users/signup'
      end
    
    post '/signup' do 
        user = User.new(username: params[:username], email: params[:email], password: params[:password])
    
            if user.save
                session[:user_id] = user.id 
                redirect "/posts"
            else
                redirect "/signup"
            end
        
    end
    
    get '/login' do 
        erb :'users/login'
    end

    post '/login' do 
        if logged_in?
            redirect "/posts"
        else
            user && user.authenticate(params[:password])
        
        end
        
    end

    get '/logout' do
        if logged_in?
            session.clear
        else
            redirect "/login"
        end
    end

end