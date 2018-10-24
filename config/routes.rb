Rails.application.routes.draw do
  #devise_for :admin_users, ActiveAdmin::Devise.config
  devise_config = ActiveAdmin::Devise.config
  devise_config[:controllers][:omniauth_callbacks] = 'admin_users/omniauth_callbacks'
  devise_for :admin_users, devise_config
  ActiveAdmin.routes(self)
  root :to => 'admin/cryptos#index'
  #resources :main_menus
  #resources :manuscripts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get "admin/app_detail/change_graph"
end
