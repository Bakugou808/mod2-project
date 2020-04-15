class AuthController < ApplicationController

    #similar to our new ->takes us to the login page
    def new 
    end 

    #similar to create -> takes data from our login page and verifies data
    def create 
        # @user = User.find_by(username: params[:auth][:username])
        @user = User.find_by(username: params[:auth][:username])
        
        return head(:forbidden) unless @user.authenticate(params[:auth][:password])
        session[:user_id] = @user.id
        redirect_to @user 
        # if @user
        #     session[:user_id] = @user.id
        #     redirect_to @user  
        # else
        #     render :new 
        # end
    end 


  
end