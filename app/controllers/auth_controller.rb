class AuthController < ApplicationController

    #similar to our new ->takes us to the login page
    def new 
    end 

    #similar to create -> takes data from our login page and verifies data
    def create 
        
        @user = User.find_by(username: params[:auth][:username])
        
        if @user
            @user.authenticate(params[:auth][:password])
            session[:user_id] = @user.id
            redirect_to @user 
        else 
            render :deny
        end 
            # return head(:forbidden) 
        #     unless @user.authenticate(params[:auth][:password])
        # session[:user_id] = @user.id
        # redirect_to @user 

    end 

    def deny
    end 

    def logout
        session.delete :user_id 
        redirect_to strains_path
    end 




  
end