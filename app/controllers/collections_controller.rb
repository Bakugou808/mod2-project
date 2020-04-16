class CollectionsController < ApplicationController
    before_action :set_collection, only: [:show, :edit, :update, :destroy]
    before_action :redirect_user
    before_action :current_user


    def index
        
        @strains = Strain.all 
        @collection = Collection.new 
        @collection.notes.build
        @genusi = @user.avail_genus
        @flavors = @user.flavors 
        @pos_med_effects = @user.positive_effects
        
        if params[:results] 
            if params[:results].class == Array
                @results = params[:results].uniq.map{|id| Strain.find(id.to_i)}
            else 
                @results = params[:results]
            end
        end 

    end



    # def new
    #     @collection = Collection.new 
    # end 

    def create 
        @collection = @user.collections.build(collection_params)

        if @collection.save
            redirect_to @collection
        else 
            flash[:error_messages] = @collection.errors.full_messages 
            render :new 
        end 
    end 

    def add_to_collection
        
        @strain = Strain.find(params[:strain_id])
        @collection = Collection.new(user_id: @user.id, strain_id: @strain.id)
        if @collection
            @collection.save 
            redirect_to collection_path(@collection)
        else 
            render :incompleted
        end
    end

    def show
        
        @strain = Strain.find(@collection.strain_id)
        
        cookies[:collection_id] = @collection.id
    end 

    def edit 
        
        @notes = @collection.notes 
    end 

    def update 
        if @collection.update(user_id: @user.id, strain_id: collection_params[:strain_id])
            redirect_to @collection
        else 
            flash[:error_messages] = @collection.errors.full_messages 
            render :edit 
        end 
    end 

    def destroy 
        @collection.destroy
        redirect_to homepage_path
    end
    
    #------------------------------------------------

    def view_all 
        
        @list = @user.all_strains  
    end 
    def sativas
        @list = @user.search_genus("sativa")
    end

    def hybrids
        @list = @user.search_genus("hybrid")
    end

    def indicas
        @list = @user.search_genus("indica")
    end

    def positives
        @list = @user.positive_effects
    end

    def matches 
        @list = @user.matched_attribute(params[:attribute])
    end 

    def medicinal
        @list = @user.negative_effects
    end

    def flavors
        @list = @user.flavors
    end

    def result 
        @results = @user.my_results(params[:genus], params[:flavors], params[:effects])
        
        redirect_to homepage_path(results: @results) 
    end 

    #------------------------------------------------


    private 

    def set_collection
        @collection = Collection.find(params[:id])
    end 


    def collection_params
        params.require(:collection).permit(:strain_id, :user_id, notes_attributes: [:date, :rating, :vendor, :note])
    end

    def incompleted 
    end

end





















       # @collection.notes.build

        # @users_collection = @user.collections
        # @strains = @user.strains 
        # @flavors = @user.flavors 
        # @pos_med_effects = @user.positive_effects
        # @neg_effects = @user.negative_effects
        # # @genusi = {{:name => "Sativa"}, {:name => "Hybrid"}, {:name => "Indica"}}
        # @sativas = @user.search_genus("sativa")
        # @hybrids = @user.search_genus("hybrid")
        # @indicas = @user.search_genus("indica")

        # <%= form_for @collection do |f| %>
        #     <%= f.collection_select :genus, Strain.all, :genus, :genus %>
        #     <%= f.submit %>
        # <% end %>x



        # redirect_to collection_results_path