class PostController < ApplicationController


    get '/posts' do
        redirect_if_not_logged_in
        ##didn't need @user
         @posts = current_user?.posts
         erb :'posts/index'
    end

    get '/posts/new' do 
        ##adds protection to new post form
       redirect_if_not_logged_in
        erb :'posts/new'
     
    end

    post '/posts' do 
       redirect_if_not_logged_in
       post = current_user?.posts.new(params)
       post.save
       flash[:message] = "Post successfully created!"
       redirect "/posts/#{post.id}"
      
       
    end

##added new helper methods and got rid of nested if statement
    get '/posts/:id' do
        redirect_if_not_logged_in
        redirect_if_not_found
        erb :'posts/show_post'
     
    end

    get '/posts/:id/edit' do
        redirect_if_not_logged_in
        redirect_if_not_found
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