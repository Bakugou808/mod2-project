class CollectionsController < ApplicationController
    before_action :set_collection, only: [:index, :show, :edit, :update, :destroy]
    before_action :redirect_user
    def index
         @users_collection = current_user.collections 
    end

    def new
        @collection = Collection.new 
    end 

    def create 
        @collection = Collection.new(collection_params)
        if @collection.save
            redirect_to @collection
        else 
            flash[:error_messages] = @collection.errors.full_messages 
            render :new 
        end 
    end 

    def add_to_collection
        byebug
        @strain = Strain.find(params[:strain_id])
        @user = current_user 
        @collection = Collection.new(user_id: @user.id, strain_id: @strain.id)
        if @collection
            @collection.save 
            redirect_to collection_path(@collection)
        else 
            redirect_to incompleted_path
        end
    end

    def incompleted 

    end

    def show
        @strain = Strain.find(@collection.strain_id)
        @user = User.find(@collection.user_id)
    end 

    def edit 
    end 

    def update 
        if @collection.update(collection_params)
            redirect_to @collection
        else 
            flash[:error_messages] = @collection.errors.full_messages 
            render :edit 
        end 
    end 

    def destroy 
        @collection.destroy
        redirect_to new_collection_path
    end 

    private 

    def set_collection
        @collection = Collection.find(params[:id])
    end 

    def collection_params
        params.require(:collection).permit(:user_id, :strain_id)
    end


end
