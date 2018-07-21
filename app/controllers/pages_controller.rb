class PagesController < ApplicationController
    
    # home action
    def home
        redirect_to articles_path if logged_in?
    end
    
    # about action
    def about
        
    end
end