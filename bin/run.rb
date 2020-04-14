require_relative "../config/environment.rb"


puts "hiiii" 
byebug
terpene_data = SmarterCSV.process( 'app/results.csv' ) #count 8905 Acquires lab results

strain_names = Strain.list_of_strain_names #count 1970 Acquires cannabis strain descriptions from API


match_list = []

#count 1281 - finds matching names from lab results
match_list = terpene_data.select{|strain| strain_names.to_enum.include?(strain[:sample_name])} 
#count 441  - filters through matches to only select flower results
flower_list = match_list.select{|strain| strain[:sample_type] == "Flower, Inhalable" } 
#orders flower_list by first letter --> ordered_list["A"] --> will provide every strain beginning with "A"
ordered_list = flower_list.group_by { |strain| strain[:sample_name][0] } 
#isolate key-value pairs by float type
.select{|key, value| value.class == Float}
#filter to terps that are greater that 0.0000m -> store this into chemical profile 
.select{|terp, val| value.class == Float && val > 0.0000} 

#you have an flower_list of all the flower results. iterate through each one and store the sample_name 
#as the name in within the lab table
#within the chemical profile column, iterate through flower_list and select

flower_list.each do |strain| 

    LabResult.create(strain_id: Strain.find_by(name: strain[:sample_name]), name: strain[:sample_name], chem_profile: strain.select{|terp, val| val.class == Float && val > 0.0000})

end 

strain_names.each do |strain|
    Strain.create(name: strain, description: get_desc(strain), flavors: get_flavors(get_id(strain)) , genus:get_genus(strain) , effects: get_effects(get_id(strain)))

end 

