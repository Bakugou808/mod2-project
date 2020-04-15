class LabResult < ApplicationRecord
    belongs_to :strain 

    def terps
        results = self.to_hash(self.chem_profile)
    end

    #give credit to http://billpatrianakos.me/blog/2015/05/31/turn-a-string-into-a-hash-with-string-dot-to-hash-in-ruby/
    def to_hash(arr_sep=', :', key_sep='=>', results)
        
        results.chop!
        results.reverse!.chop!
        results.chop!
        results.reverse!

        array = results.split(arr_sep)
        hash = {}
    
        array.each do |e|
          key_value = e.split(key_sep)
          hash[key_value[0]] = key_value[1]
        end
    
        return hash
    end
    

    def sort_terps
        
    end

end
