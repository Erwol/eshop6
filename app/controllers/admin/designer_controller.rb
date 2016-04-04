class Admin::DesignerController < ApplicationController
  def new
    @designer = Designer.new
    @page_title = "Añadir un nuevo diseñador"
  end

  def create
    # Se invoca tras pulsar el botón del formulario en views/admin/providerss
    @designer = Designer.new(designer_params)
    if @designer.save
      flash[:notice] = "El diseñador #{@designer.name} fue añadido correctamente."
      redirect_to :action => 'index'
    else
      @page_title = 'Crear nuevo diseñador'
      render :action => 'new'
    end
  end

  def edit
    @designer = Designer.find(params[:id])
    @page_title = 'Editar diseñador'
  end

  def update
    @designer = Designer.find(params[:id])
    if @designer.update_attributes(designer_params)
      flash[:notice] = "La información del diseñador #{@designer.name} se actualizó correctamente."
      redirect_to :action => 'show', :id => @designer
    else
      @page_title = 'Editar proveedor'
      render :action => 'edit'
    end
  end

  def destroy
    @designer = Designer.find(params[:id])
    @designer.destroy
    flash[:notice] = "El diseñador #{@designer.name} fue eliminado correctamente."
    redirect_to :action => 'index'
  end

  def show
    @designer = Designer.find(params[:id])
    @page_title = @designer.name
  end

  def index
    @designers = Designer.all
    @page_title = 'Listado de diseñadores'
  end

  private
  def designer_params
    params.require(:designer).permit(:name, :telephone, :enterprise)
  end
end
