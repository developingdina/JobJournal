class PostController < ApplicationController


    get '/posts' do
        if logged_in? 
           ##didn't need @user
            @posts = current_user?.posts
            erb :'posts/index'
        else
            redirect "/login"
        end
    end

    get '/posts/new' do 
        ##adds protection to new post form
        if logged_in?
            erb :'posts/new'
        else 
            flash[:errors] = "You need to login to do that!"
                redirect "/login"
            end
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

##added new helper methods and got rid of nested if statement
    get '/posts/:id' do
        if logged_in? && post_by_user 
            erb :'posts/show_post'
        else
            flash[:errors] = "Sorry that doesn't exist."
            redirect "/posts"
        end
    end

    get '/posts/:id/edit' do
        post_by_user
        erb :'posts/edit_post'
    end
##A way to nest the params hash so that attributes do not have to be spelled out
    patch '/posts/:id' do 
        post_by_user
        @post.update_attributes(company_name: params[:company_name], position_title: params[:position_title], applied: params[:applied], description: params[:description])
        @post.save
        flash[:message] = "Post successfully updated!"
        redirect "/posts/#{@post.id}"
    end

    delete '/posts/:id' do
        post_by_user
        @post.delete 
        flash[:message] = "Post successfully deleted!"
        redirect "/posts"
    end
end