class User < ApplicationRecord
    has_many :collections
    has_many :strains, through: :collections
    has_many :notes, through: :collections 
    has_secure_password
    # allows_nested_attributes_for :strains

    def password=(new_password)
        salt = BCrypt::Engine::generate_salt
        hashed = BCrypt::Engine::hash_secret(new_password, salt)
        self.password_digest = salt + hashed 
    end

    def authenticate(password)
        
        salt = password_digest[0..28]
        hashed = BCrypt::Engine::hash_secret(password, salt)
        if (salt + hashed) == self.password_digest
            return true
        else 
            nil 
        end 
    end


end
 