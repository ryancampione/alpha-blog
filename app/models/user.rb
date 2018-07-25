class User < ActiveRecord::Base
    has_many :articles, dependent: :destroy
    
    before_save {
        self.username = username.downcase
        self.email = email.downcase
    }
    
    INVALID_USERNAME_REGEX = /\s/i
    
    validates :username, 
        presence: true, 
        uniqueness: {case_sensitive: false}, 
        length: {minimum: 3, maximum: 25},
        format: {without: INVALID_USERNAME_REGEX}
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
        
    validates :email,
        presence: true,
        uniqueness: {case_sensitive: false},
        length: {maximum: 105},
        format: {with: VALID_EMAIL_REGEX}
        
    has_secure_password
    
    validates :password,
        length: {minimum: 8}
    
end