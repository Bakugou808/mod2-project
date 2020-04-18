class Collection < ApplicationRecord
    belongs_to :user
    belongs_to :strain 
    has_many :notes 
    has_many :tags
    accepts_nested_attributes_for :notes, :tags
    # accepts_nested_attributes_for :tags 


    # def notes_attributes=(note)
    #     self.notes << Note.create(date: note[:date], rating: note[:rating], vendor: note[:vendor], note: note[:note])
    #     self.notes.save
    #     # self.notes.update(note)
    # end 
    # def search_attributes=(search)
    #     self.search = 
    # end 
end
