class ArticlesController < ApplicationController
   
   #all articles index
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
         flash[:notice] = "Article was successfully created"
         redirect_to article_path(@article)
      else
         render 'new'
      end
   end
   
   # edit article template
   def edit
      @article = Article.find(params[:id])
   end
   
   # update article in the Article table
   def update
      @article = Article.find(params[:id])
      
      if @article.update(article_params)
         flash[:notice] = "Article was successfully updated"
         redirect_to article_path(@article)
      else
         render 'edit'
      end
      
   end
   
   def destroy
      @article = Article.find(params[:id])
      @article.destroy
      
      flash[:notice] = "Article was successfully deleted"
      redirect_to article_path()
   end
   
   # display an article
   def show
      @article = Article.find(params[:id])
   end
   
   private
      def article_params
         params.require(:article).permit(:title, :description)
      end
end