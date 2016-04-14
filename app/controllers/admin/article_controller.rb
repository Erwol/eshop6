class Admin::ArticleController < ApplicationController
  def new
    load_data
    @article = Article.new
    @page_title = 'Create new article'
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article #{@article.title} was succesfully created."
      redirect_to :action => 'index'
    else
      load_data
      @page_title = 'Create new article'
      render :action => 'new'
    end
  end

  def edit
    load_data
    @article = Article.find(params[:id])
    @page_title = 'Edit article'
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:notice] = "Article #{@article.title} was succesfully updated."
      redirect_to :action => 'show', :id => @article
    else
      load_data
      @page_title = 'Edit article'
      render :action => 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Succesfully deleted article #{@article.title}."
    redirect_to :action => 'index'
  end

  def show
    @article = Article.find(params[:id])
    @page_title = @article.title
  end

  def index
    sort_by = params[:sort_by]
    @articles = Article.order(sort_by).paginate(:page => params[:page], :per_page => 5)
    @page_title = 'Listing articles'
  end

  private

  def load_data
    @designers = Designer.all
    @providers = Provider.all
  end

  def article_params
    params.require(:article).permit(:title, :provider_id, :provided_at, { :designer_ids => [] },
                                    :description, :price)
  end
end
