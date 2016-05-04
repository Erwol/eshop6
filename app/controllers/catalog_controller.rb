class CatalogController < ApplicationController
  before_filter :initialize_cart, :except => :show
  # before_filter :require_no_user

  def show
    @article = Article.find(params[:id])
    @page_title = @article.name
  end

  def index
    @articles = Article.order("articles.id desc").includes(:designers, :provider).paginate(:page => params[:page], :per_page => 5)
    @page_title = 'Catálogo de artículos'
  end

  def latest
    @articles = Article.latest 5 # invoques "latest" method to get the five latest articles
    @page_title = 'Últimos artículos'
  end
end
