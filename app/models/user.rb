class User < ApplicationRecord
    has_many :collections
    has_many :strains, through: :collections
    has_many :notes, through: :collections 
    has_many :comments 
    has_many :strains, through: :comments

    has_secure_password
    # allows_nested_attributes_for :strains


    def flavors
        
        @users_strains = self.strains 
        @strain_flavors = @users_strains.map{|strain| strain.flavors.split(" - ")}.flatten.uniq 
    end 


    def positive_effects
        @positive_effects = self.strains.map{|strain| strain.effects.split("||")}.map{|arr| arr[0] + arr[2]}.flatten.join(" ").gsub("Positives:", "-").gsub("Medicinal:", "-").split("-").map{|effect| effect.strip}.reject(&:empty?).uniq
    end

    def matched_attribute(attribute)
        collections = self.collections 
        strains = collections.map{|collection| Strain.find(collection.strain_id)}
        match = strains.select{|strain| strain.effects.include?(attribute) || strain.flavors.include?(attribute)}
    end

    def negative_effects
        @negative_effects = self.strains.map{|strain| strain.effects.split("||")}.map{|arr| arr[1] }.flatten.join(" ").gsub("Negatives:", "-").split("-").map{|effect| effect.strip}.reject(&:empty?).uniq
    end

    def password=(new_password)
        salt = BCrypt::Engine::generate_salt
        hashed = BCrypt::Engine::hash_secret(new_password, salt)
        self.password_digest = salt + hashed 
    end

    def search_genus(genus)
        strains = self.strains.select{|strain| strain.genus.downcase == "#{genus.downcase}"}
        if !strains.empty?
            strains 
        else 
            "No #{genus.capitalize()}s In Your Collection"
        end 
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
 