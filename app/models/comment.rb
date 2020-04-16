class Comment < ApplicationRecord
    belongs_to :strain 
    belongs_to :user 
end
