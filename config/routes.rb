Rails.application.routes.draw do

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
  get 'admin/provider' => 'admin/provider#index'
  get 'admin/provider/new'
  post 'admin/provider/create'
  get 'admin/provider/edit'
  post 'admin/provider/update'
  post 'admin/provider/destroy'
  get 'admin/provider/show'
  get 'admin/provider/show/:id' => 'admin/provider#show'
  get 'admin/provider/index'


end
