class PostController < ApplicationController


    get '/posts' do
        if logged_in? 
            @user = current_user?.username
            @posts = Post.all
            erb :'posts/index'
        else
            redirect "/login"
        end
    end

    get '/posts/new' do 
        erb :'posts/new'
    end

    post '/posts' do 
        if logged_in?
            post = Post.new(company_name: params[:companyname], position_title: params[:positiontitle], applied: params[:dateapplied], description: params[:description])
            post.user_id = session[:user_id]
            post.save
            flash[:message] = "Post successfully created!"
            redirect "/posts/#{post.id}"
        else
            redirect "/login"
        end
       
    end


    get '/posts/:id' do
        if logged_in?
            @post = Post.find_by_id(params[:id])
            if @post == nil
                redirect "/posts"
            else
                erb :'posts/show_post'
            end
        else
            redirect "/login"
        end
    end

    get '/posts/:id/edit' do
        @post = Post.find_by_id(params[:id])
        erb :'posts/edit_post'
    end

    patch '/posts/:id' do 
        post = Post.find_by_id(params[:id])
        post.company_name = params[:companyname]
        post.position_title = params[:positiontitle]
        post.description = params[:description]
        post.applied = params[:dateapplied]
        post.save
        flash[:message] = "Post successfully updated!"
        redirect "/posts/#{post.id}"
    end

    delete '/posts/:id' do
        @post = Post.find_by_id(params[:id])
        @post.delete 
        flash[:message] = "Post successfully deleted!"
        redirect "/posts"
    end
end