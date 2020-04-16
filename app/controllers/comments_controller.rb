class CommentsController <ApplicationController

    def new 
        byebug
        @comment = Comment.new 
    end

    def create 
        byebug
        @comment = Comment.new(comment_params)
        @strain = Strain.find(comment_params[:strain_id])
        if @comment.save 
            redirect_to strain_path(@strain.id)
        end
    end 

    def destroy

    end 


    private 

    def comment_params 
        params.require(:comment).permit(:user_id, :strain_id, :comment)
    end

end