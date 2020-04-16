class Note < ApplicationRecord
    belongs_to :collection
    validates :rating, :inclusion => -10..10

end
