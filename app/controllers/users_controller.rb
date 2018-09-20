class UsersController < ApplicationController
    
    # run the set_user method first for these methods
    before_action :set_user, only: [:edit, :update, :show, :destroy]
    
    # first require the same user
    before_action :require_same_user, only: [:edit, :update]
    
    # first require an admin user
    before_action :require_admin_user, only: [:index, :destroy]
    
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
            session[:user_id] = @user.token
            redirect_to user_path(@user)
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
    
    def destroy
        flash[:warning] = "#{@user.username} and all articles created by this user have been deleted"
        @user.destroy
        redirect_to users_path
    end
    
    private
    def user_params
        # whitelist possible paramaters
        params.require(:user).permit(:username, :email, :password)
    end
    
    def set_user
        @user = User.find_by_token(params[:id])
    end
    
    def require_same_user
        if !logged_in? || (current_user != @user && !current_user.admin?)
            flash[:danger] = "You can only edit your own profile"
            redirect_to root_path
        end
    end
    
    def require_admin_user
       if logged_in? && !current_user.admin? 
          flash[:danger] = "Only an admin can preform this action"
          redirect_to root_path
       end
    end
end