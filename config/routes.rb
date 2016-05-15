Rails.application.routes.draw do


  get 'about' => 'about#index'
  get 'checkout' => 'checkout#index'
  get 'admin/designer' => 'admin/designer#index'
  get 'admin/publisher' => 'admin/publisher#index'
  get 'admin/book' => 'admin/book#index'
  get 'admin/order' => 'admin/order#index'

  post 'admin/order/close'
  post 'admin/order/destroy'
  get 'admin/order/show'
  get 'admin/order/show/:id' => 'admin/order#show'
  get 'admin/order/index'
  get 'admin/order' => 'admin/order#index'

  get 'checkout/index'
  get 'checkout/place_order'
  get 'checkout/thank_you'

  root :to => 'catalog#index'
  # root :to => 'about#index'
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

  get 'catalog' => 'catalog#index'
  get 'catalog/show'
  get 'catalog/show/:id' => 'catalog#show'
  get 'catalog/index'
  get 'catalog/latest'


  get 'checkout' => 'checkout#index'
  post 'checkout/submit_order'

  get 'cart/add'
  post 'cart/add'
  get 'cart/remove'
  post 'cart/remove'
  get 'cart/clear'
  post 'cart/clear'

  get 'user_sessions/new'
  get 'user_sessions/create' # for showing failed login screen after restarting web server
  post 'user_sessions/create'
  get 'user_sessions/destroy'

  get 'user/new'
  post 'user/create'
  get 'user/show'
  get 'user/show/:id' => 'user#show'
  get 'user/edit'
  post 'user/update'
end
