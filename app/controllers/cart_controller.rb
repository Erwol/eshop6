class CartController < ApplicationController
  before_filter :initialize_cart

  def add
    @article = Article.find params[:id]
    @page_title = 'Añadir artículo'
    if request.post?
      @item = @cart.add params[:id]
      flash[:cart_notice] = "<em>#{@item.article.name}</em> añadido."
      redirect_to :controller => 'catalog'
    else
      render :controller => 'cart', :action => 'add', :template => 'cart/add'
    end
  end

  def remove
    @article = Article.find params[:id]
    @page_title = 'Eliminar artículo'
    if request.post?
      @item = @cart.remove params[:id]
      flash[:cart_notice] = "Eliminado un <em>#{@item.article.name}</em>."
      redirect_to :controller => 'catalog'
    else
      render :controller => 'cart', :action => 'remove'
    end
  end

  def clear
    @page_title = 'Vaciar carrito'
    if request.post?
      @cart.cart_items.destroy_all
      flash[:cart_notice] = "¡El carrito ha sido vaciado!"
      redirect_to :controller => 'catalog'
    else
      render :controller => 'cart', :action => 'clear'
    end
  end
end
