Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    get :status, to: 'status#index'
    resources :users, only: :create do
      collection do
        get :list_hubspot_users
      end
    end
  end
  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
