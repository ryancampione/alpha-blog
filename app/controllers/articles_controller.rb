class ArticlesController < ApplicationController
   # run the set_article method first for these methods
   before_action :set_article, only: [:edit, :update, :show, :destroy]
   
   # all articles index
   def index
      @articles = Article.all
   end
   
   # new article template
   def new
      @article = Article.new
   end
   
   # create a new article in the Article table
   def create
      #render plain: params[:article].inspect
      
      @article = Article.new(article_params)
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
      
      flash[:danger] = "Article was successfully deleted"
      redirect_to articles_path
   end
   
   private
      def article_params
         params.require(:article).permit(:title, :description)
      end
      
      def set_article
         @article = Article.find(params[:id])
      end
end