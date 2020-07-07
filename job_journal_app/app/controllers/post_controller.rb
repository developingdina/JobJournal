class PostController < ApplicationController


    get '/posts' do
        if logged_in? && current_user?
            @post = Post.all
            erb :'posts/index'
        else
            redirect "/login"
        end
    end

    get '/posts/new' do 
        erb :'posts/new'
    end

    post '/create' do 
        @post = Post.new(content)
    end

end