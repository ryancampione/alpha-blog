class Category < ActiveRecord::Base
    
    before_save {
        self.name = name.titleize
    }
    
    validates :name, 
        presence: true,
        uniqueness: {case_sensitive: false},
        length: {minimum: 3, maximum: 25}
        
end