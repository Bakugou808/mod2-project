class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    def new 
        @user = User.new
    end 

    def create 
        @user = User.new(user_params)
        if @user.save 
            redirect_to @user 
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
        redirect_to strains_path 
    end 

    private 

    def set_user 
        @user = User.find(params[:id])
    end 

    def user_params
        params.require(:user).permit(:username, :interests, :favorites)
    end

end