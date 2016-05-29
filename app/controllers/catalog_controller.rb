class CatalogController < ApplicationController
  before_filter :initialize_cart, :except => :show
  before_filter :require_no_user

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

  def tags
    @articles = Article.joins(:taggings).where 'tag_id LIKE ?', "%#{params[:id]}%"
    @page_title = 'Catálogo de artículos'
  end



  def rss
    latest
    render :layout => false
    response.headers["Content−Type"] = "application/xml; version = 1.0; charset=utf−8"
  end

  def search
    @page_title = "Buscar"
    if params[:commit] == "Buscar" || params[:q]
      @articles = Article.where 'name LIKE ?', "%#{params[:q]}%"
      unless @articles.size > 0
        flash.now[:notice] = "No se ha encontrado el artículo."
      end
    end
  end
end
