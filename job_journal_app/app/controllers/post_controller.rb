class PostController < ApplicationController


    get '/posts' do
        @post = Post.all
        erb :'posts/index'
    end


end