class ArticlesController < ApplicationController
   
   # run the set_article method first for these methods
   before_action :set_article, only: [:edit, :update, :show, :destroy]

   # first require a logged user for all methods except for   
   before_action:require_user, except: [:index, :show]
   
   # first require user to be the article's creator
   before_action :require_creator_user, only: [:edit, :update, :destroy]
   
   # all articles index
   def index
      @articles = Article.paginate(page: params[:page], per_page: 5)
   end
   
   # new article template
   def new
      @article = Article.new
   end
   
   # create a new article in the Article table
   def create
      @article = Article.new(article_params)
      
      # set current user as the article's creator
      @article.user = current_user
      
      if @article.save
         flash[:success] = "Article was successfully created"
         redirect_to article_path(@article)
      else
         render 'new'
      end
   end
   
   # edit article template
   def edit
      
   end
   
   # update article in the Article table
   def update
      
      if @article.update(article_params)
         flash[:success] = "Article was successfully updated"
         redirect_to article_path(@article)
      else
         render 'edit'
      end
      
   end
   
   # display an article
   def show

   end
   
   # delete an article
   def destroy
      @article.destroy
      
      flash[:success] = "Article was successfully deleted"
      redirect_to articles_path
   end
   
   private
      def article_params
         params.require(:article).permit(:title, :description)
      end
      
      def set_article
         @article = Article.find(params[:id])
      end
      
      def require_creator_user
         if current_user != @article.user
            flash[:danger] = "You can only edit or delete your own articles"
            redirect_to root_path
         end
      end
end