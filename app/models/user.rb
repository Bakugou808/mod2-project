class User < ApplicationRecord
    has_many :collections
    has_many :strains, through: :collections
    has_many :notes, through: :collections 
    has_many :comments 
    validates :username, presence: true 
    

    has_secure_password
    # allows_nested_attributes_for :strains

    def all_strains 
        list = self.collections.map{|collection| Strain.find(collection.strain_id)}
    end 

    def flavors
        
        @users_strains = self.strains 
        @strain_flavors = @users_strains.map{|strain| strain.flavors.split(" - ")}.flatten.uniq 
    end 

    def my_results(genus, flavors, effects)

        matches = self.strains.select{|strain| genus.any? {|genus| strain.genus == genus} && flavors.any? {|flavor| strain.flavors.split(" ").include?(flavor)} &&  effects.any? {|effect| strain.effects.split(" ").include?(effect)}}
        
        if !matches.empty?
            matches
        else
            "No Matches Found"
        end
    end

    def positive_effects
        @positive_effects = self.strains.map{|strain| strain.effects.split("||")}.map{|arr| arr[0] + arr[2]}.flatten.join(" ").gsub("Positives:", "-").gsub("Medicinal:", "-").split("-").map{|effect| effect.strip}.reject(&:empty?).uniq
    end

    def search_genus(genus)
        
        # strains = self.collections.map{|collection| 
        #     st = Strain.find(collection.strain_id) 
        #     st.genus.downcase == "#{genus.downcase}" 
        # }
        strains = self.collections.map{|collection| Strain.find(collection.strain_id) if Strain.find(collection.strain_id).genus.downcase == "#{genus.downcase}"}.compact
        # strains = self.collections.select{|strain| strain.genus.downcase == "#{genus.downcase}"}
        
        if !strains.empty?
            strains 
        else 
            "No #{genus.capitalize()}s In Your Collection"
        end 
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

    def avail_genus 
        genus = self.strains.map{|strain| strain.genus }.uniq
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
 