class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :redirect_user, only: [:show, :delete, :edit, :destroy]

    def new 
        @user = User.new 
    end 

    def create 
  
        
        @user = User.new(user_params)
        if @user.save 
            session[:user_id] = @user.id 
            redirect_to @user #collections_homepage 
        else 
            flash[:error_messages] = @user.errors.full_messages 
            render :new 
        end 
    end 

    def show  
    end 

    def edit 
    end 

    def update 
        if @user.update(user_params)
            redirect_to @user
        else 
            flash[:error_messages] = @user.errors.full_messages 
            render :edit 
        end 
    end

    def destroy
        @user.destroy 
        redirect_to login_path 
    end 

    private 

    def set_user 
        @user = User.find(params[:id])
    end 

    def user_params
        params.require(:user).permit(:username, :interests, :favorites, :password, :password_confirmation)
    end

  
end
