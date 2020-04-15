# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require_relative '../app/data/api_communications.rb'


Note.delete_all 
User.delete_all 
Collection.delete_all 
LabResult.delete_all
Strain.delete_all 


terpene_data = SmarterCSV.process( 'app/data/results.csv' ) #count 8905 Acquires lab results
strain_names = Strain.list_of_strain_names #count 1970 Acquires cannabis strain descriptions from API

#count 1281 - finds matching names from lab results
match_list = terpene_data.select{|strain| strain_names.to_enum.include?(strain[:sample_name])} 
#count 441  - filters through matches to only select flower results
flower_list = match_list.select{|strain| strain[:sample_type] == "Flower, Inhalable" } 
#strains_to_add 
added_strains = flower_list.map{|lab| lab[:sample_name] }.uniq



# fill in strains table
added_strains.each do |strain|
    strain_info = ApiCommunications.new
    id = strain_info.get_id(strain)
    if !Strain.find_by(name: strain)
        Strain.create(name: strain, description: strain_info.get_desc(id), flavors: strain_info.get_flavors(id) , genus: strain_info.get_genus(strain) , effects: strain_info.get_effects(id))
    end 
end 


# fill in labresults table
flower_list.each do |strain| 
    if !LabResult.find_by(strain_id: Strain.find_by(name: strain[:sample_name]).id)
        strain_id = Strain.find_by(name: strain[:sample_name]).id
        name = strain[:sample_name]
        chem_profile = strain.select{|terp, val| val.class == Float && val > 0.0000}
        
        LabResult.create(strain_id: strain_id, name: name, chem_profile: chem_profile)
    end 
end 

