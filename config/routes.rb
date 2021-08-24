Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create] do
        resources :vaults
      end
      post 'login', to: 'sessions#create'
      get 'logout', to: 'sessions#destroy'
    end
  end
end
