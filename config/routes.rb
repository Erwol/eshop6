Rails.application.routes.draw do

  namespace :admin do
  get 'designer/new'
  end

  namespace :admin do
  get 'designer/create'
  end

  namespace :admin do
  get 'designer/edit'
  end

  namespace :admin do
  get 'designer/update'
  end

  namespace :admin do
  get 'designer/destroy'
  end

  namespace :admin do
  get 'designer/show'
  end

  namespace :admin do
  get 'designer/index'
  end

  namespace :admin do
  get 'provider/new'
  end

  namespace :admin do
  get 'provider/create'
  end

  namespace :admin do
  get 'provider/edit'
  end

  namespace :admin do
  get 'provider/update'
  end

  namespace :admin do
  get 'provider/destroy'
  end

  namespace :admin do
  get 'provider/show'
  end

  namespace :admin do
  get 'provider/index'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Petición, sirve para cuando no se pone nada
  root :to => 'about#index'
  get 'about' => 'about#index'
  get 'about/index'

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
