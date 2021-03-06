class Admin::ArticleController < Admin::AuthenticatedController
  def new
    load_data
    @article = Article.new
    @page_title = 'Crear un nuevo artículo'
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "El artículo #{@article.name} fue creado correctamente."
      redirect_to :action => 'index'
    else
      load_data
      @page_title = 'Crear un nuevo artículo'
      render :action => 'new'
    end
  end

  def edit
    load_data
    @article = Article.find(params[:id])
    @page_title = 'Editar artículo'
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:notice] = "El artículo #{@article.name} fue actualizado correctamente."
      redirect_to :action => 'show', :id => @article
    else
      load_data
      @page_title = 'Editar artículo'
      render :action => 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "El artículo #{@article.name} fue eliminado correctamente."
    redirect_to :action => 'index'
  end

  def show
    @article = Article.find(params[:id])
    @page_title = @article.name
  end

  def index
      sort_by = params[:sort_by]
      @articles = Article.order(sort_by).paginate(:page => params[:page], :per_page => 5)
      @page_title = 'Listado de artículos'
  end

  private

  def load_data
    @designers = Designer.all
    @providers = Provider.all
  end

  def article_params
    params.require(:article).permit(:name, :provider_id, :provided_at, { :designer_ids => [] },
                                    :description, :price, :cover_image, :tag_list)
  end
end
