class PagesController <ApplicationController

    def search  
        
        if params[:search].blank?  
          redirect_to(strains_path, alert: "Empty field!") and return  
        else  
          @parameter = params[:search].downcase.strip  
          @results = Strain.all.select{|strain| strain.name.downcase.include?(@parameter)}
        #   where("lower(name) LIKE :search", search: @parameter)  c
        end  
    end

end