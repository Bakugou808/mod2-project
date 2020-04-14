class StrainsController < ApplicationController

    def index 
        @strains = Strain.all
    end

    def show
        @strain = Strain.find(params[:id])
    end 


end