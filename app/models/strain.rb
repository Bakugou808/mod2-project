class Strain < ApplicationRecord
    has_many :lab_results
    has_many :collections 
    has_many :users, through: :collections

    def self.list_of_strain_names
        api_key = "l7yuhjl"
        response_string = RestClient.get("strainapi.evanbusse.com/#{api_key}/strains/search/all")
        parsed_arr = JSON.parse(response_string)
        list_of_strains = parsed_arr.keys
        # hash_of_name_groups = list_of_strains.group_by { |name| name[0] } 
    end 


    

end
