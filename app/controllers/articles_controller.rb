class ArticlesController < ApplicationController
  def index
    @articles = Article.all

  end

  def show
    @article = Article.find(params[:id])
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

  end
end
