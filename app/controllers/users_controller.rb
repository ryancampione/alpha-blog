class UsersController < ApplicationController
    
    before_action :set_user, only: [:edit, :update, :show]
    
    # index user template
    def index
       @users = User.paginate(page: params[:page], per_page: 5)
    end
    
    
    # new user template
    def new
        @user = User.new
    end
    
    # create a new user in the User table
    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Welcome to the alpha blog #{@user.username}"
            redirect_to articles_path
        else
           render 'new' 
        end
    end
    
    # edit user template
    def edit
        
    end
   
    # update user record in the User table
    def update
        if @user.update(user_params)
          flash[:success] = "Your account was updated successfully"
          redirect_to articles_path
          
        else
            render 'edit' 
        end
    end
    
    # show user template
    def show
       
       @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end
    
    private
    def user_params
        # whitelist possible paramaters
        params.require(:user).permit(:username, :email, :password)
    end
    
    def set_user
        @user = User.find(params[:id])
    end
end