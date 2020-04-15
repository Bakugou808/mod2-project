class Collection < ApplicationRecord
    belongs_to :user
    belongs_to :strain 
    has_many :notes 

    # def strain 
    #     strains = Strain.all.select{|strain| strain.downcase.include?(@parameter)}
    # end 
end
