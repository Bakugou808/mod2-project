class User < ApplicationRecord
    has_many :collections
    has_many :strains, through: :collections
    # allows_nested_attributes_for :strains
end
