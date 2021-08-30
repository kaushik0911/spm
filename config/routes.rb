Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create] do
        resources :vaults
      end
      mount_devise_token_auth_for 'User', at: 'auth'
    end
  end
end
