class Note < ApplicationRecord
    belongs_to :collection
    belongs_to :user, through: :collection
end
