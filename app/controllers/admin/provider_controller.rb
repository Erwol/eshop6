class Admin::ProviderController < ApplicationController
  def new
    @provider = Provider.new
    @page_title = "Añadir un nuevo proveedor"


  end

  def create

    # Se invoca tras pulsar el botón del formulario en views/admin/providerss
    @provider = Provider.new(provider_params)
    if @provider.save
      flash[:notice] = "El proveedor #{@provider.name} fue añadido correctamente."
      redirect_to :action => 'index'
    else
      @page_title = 'Crear nuevo proveedor'
      render :action => 'new'
    end
  end

  def edit
    @provider = Provider.find(params[:id])
    @page_title = 'Editar proveedor'
  end

  def update
    @provider = Provider.find(params[:id])
    if @provider.update_attributes(provider_params)
      flash[:notice] = "La información del proveedor #{@provider.name} se actualizó correctamente."
      redirect_to :action => 'show', :id => @provider
    else
      @page_title = 'Editar proveedor'
      render :action => 'edit'
    end
  end

  def destroy
    @provider = Provider.find(params[:id])
    @provider.destroy
    flash[:notice] = "El proveedor #{@provider.name} fue eliminado correctamente."
    redirect_to :action => 'index'
  end

  def show
    @provider = Provider.find(params[:id])
    @page_title = @provider.name
  end

  def index
    @providers = Provider.all
    @page_title = 'Listado de proveedores'
  end

  private
  def provider_params
    # La variable se toma del formulario de origen
    # por ejemplo, cuando se accede a ella desde la función create,
    # estos valores provendrán del formulario desde el que se introdujo la
    # información.
    params.require(:provider).permit(:name, :telephone)
  end
end
