Rails.application.routes.draw do


  root :to => 'about#index'
  get 'about' => 'about#index'
  get 'about/index'

  get 'admin/article' => 'admin/article#index'
  get 'admin/article/new'
  post 'admin/article/create'
  get 'admin/article/edit'
  post 'admin/article/update'
  post 'admin/article/destroy'
  get 'admin/article/show'
  get 'admin/article/show/:id' => 'admin/article#show'
  get 'admin/article/index'



  get 'admin/provider' => 'admin/provider#index'
  get 'admin/provider/new'
  post 'admin/provider/create'
  get 'admin/provider/edit'
  post 'admin/provider/update'
  post 'admin/provider/destroy'
  get 'admin/provider/show'
  get 'admin/provider/show/:id' => 'admin/provider#show'
  get 'admin/provider/index'

  # Al llamar a una vista de una misma entidad usamos '#'
  get 'admin/designer' => 'admin/designer#index'
  get 'admin/designer/new'
  post 'admin/designer/create'
  get 'admin/designer/edit'
  post 'admin/designer/update'
  post 'admin/designer/destroy'
  get 'admin/designer/show'
  get 'admin/designer/show/:id' => 'admin/designer#show'
  get 'admin/designer/index'


end
