class NotesController < ApplicationController
    before_action :current_user
    before_action :note_setter, only: [:edit, :update, :show, :destroy]

    def index
        @notes = Note.all.select{|note| note.collection == @user.collection}
    end

    def new 
        
        @collection_id = cookies[:collection_id].to_i
        @note = Note.new 
    end 

    def create 
        
        @note = Note.new(note_params)
        if @note.save
            cookies.delete :collection 
            byebug
            redirect_to collection_path(@note.collection)
        else
            flash[:error_messages] = @note.errors.full_messages  
            render :new 
        end 
    end 

    def edit 
        @collection_id = cookies[:collection_id].to_i
    end 

    def update 
        if @note.update(note_params)
            redirect_to collection_path(@note.collection)
        else
            flash[:error_messages] = @note.errors.full_messages  
            render :edit 
        end 
    end 

    def destroy
        @note.destroy
        redirect_to homepage_path 
    end 

    private 

    def note_setter 
        @note = Note.find(params[:id])
    end

    def note_params
        params.require(:note).permit(:collection_id, :note, :rating, :vendor, :date)
    end 
end
