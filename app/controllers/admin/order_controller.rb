class Admin::OrderController < Admin::AuthenticatedController
  def close
    order = Order.find(params[:id])
    order.cerrado
    flash[:notice] = "El pedido ##{order.id} se ha cerrado."
    redirect_to :action => 'index'
  end

  def show
    @order = Order.find(params[:id])
    @page_title = "Mostrando el pedido ##{@order.id}."
  end

  def index
    @status = params[:id]
    if @status.blank?
      @status = 'todos'
      conditions = nil
    else
      conditions = "status = '#{@status}'"
    end
    @orders = Order.where(conditions).paginate(:page => params[:page], :per_page => 10)
    @page_title = "Listado de pedidos: #{@status}"
  end
end
