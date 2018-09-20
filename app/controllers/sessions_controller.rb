class SessionsController < ApplicationController
   
    # new session template (login)
    def new
   
    end
   
    # login user
    def create
        user = User.find_by(email: params[:session][:email].downcase)
        
        # user exists and password is valid
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:success] = "Welcome back #{user.username}"
            redirect_to user_path(user.token)
            
        # user invalid  
        else
            flash.now[:danger] = "Invalid login information"
            render 'new'
        end
    end
   
    # destroy session template (logout)
    def destroy
        session[:user_id] = nil
        flash[:success] = "You have successfully logged out"
        redirect_to root_path
    end

end