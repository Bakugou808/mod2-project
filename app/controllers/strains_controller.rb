class StrainsController < ApplicationController
    before_action :current_user

    def index 
        @strains = Strain.all
        # @search_strains = Strain.search(params[:search])
    end

    def show
        
        @strain = Strain.find(params[:id])
    end 

    private 

    def strain_params
        params.require(:strain).permit(:name, :strain_id, :search)
    end

end