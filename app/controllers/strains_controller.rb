class StrainsController < ApplicationController
    before_action :current_user

    def index 
        @strains = Strain.all
        # @search_strains = Strain.search(params[:search])
    end

    def show
        @comment = Comment.new
        @strain = Strain.find(params[:id])
        @comments = @strain.comments 
    end 

    def add_like 
        strain = Strain.find(params[:id])
        strain.update_column(:likes, strain.likes + 1) 
        redirect_to strain_path(strain)
    end

    private 

    def strain_params
        params.require(:strain).permit(:name, :strain_id, :search)
    end

end
