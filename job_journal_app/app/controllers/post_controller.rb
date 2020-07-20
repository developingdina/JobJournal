class PostController < ApplicationController


    get '/posts' do
        if logged_in? 
            @user = current_user?.username
            @posts = current_user?.posts
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

            post = current_user?.posts.new(params)
            post.save
            flash[:message] = "Post successfully created!"
            redirect "/posts/#{post.id}"
        else
            redirect "/login"
        end
       
    end

##added new helper method and got rid of 
    get '/posts/:id' do
        if post_by_user
            erb :'posts/show_post'
        else
            flash[:errors] = "Sorry that post doesn't exist."
            redirect "/posts"
        end
    end

    get '/posts/:id/edit' do
        post_by_user
        erb :'posts/edit_post'
    end

    patch '/posts/:id' do 
        post = current_user?.posts.find_by_id(params[:id])
        post.company_name = params[:companyname]
        post.position_title = params[:positiontitle]
        post.description = params[:description]
        post.applied = params[:dateapplied]
        post.save
        flash[:message] = "Post successfully updated!"
        redirect "/posts/#{post.id}"
    end

    delete '/posts/:id' do
        @post = current_user?.posts.find_by_id(params[:id])
        @post.delete 
        flash[:message] = "Post successfully deleted!"
        redirect "/posts"
    end
end