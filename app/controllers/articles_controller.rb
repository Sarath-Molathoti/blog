class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "111111", password: "111111", except: [:index, :show]
  def index  #will have template
    @articles = Article.all
  end

  def show  #will have template
    @article = Article.find(params[:id])
    @comment = @article.comments.build 
  end

  def new #display the new record #will have template
    @article = Article.new
  end
 
  def edit  #display form for existing record #will have template
    @article = Article.find(params[:id])
  end
 
  def create #save new record #will save and redirect
    @article = Article.new(article_params)
 
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update  #save changes #will save and redirect
    @article = Article.find(params[:id])
 
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy #will destroy and redirect
  	@article = Article.find(params[:id])
    @article.destroy
 
    redirect_to articles_path
  end
 
  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
