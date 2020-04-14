class CollectionsController < ApplicationController
    before_action :set_collection, only: [:show, :edit, :update, :destroy]
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

    def show
        @strain = Strain.find(@collection.strain_id)
        @user = User.find(@collection.user_id)
    end 

    def edit 
    end 

    def update 
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
