Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    get :status, to: 'status#index'
    resources :users, only: :create
    post :hubspot_callback, controller: :webhook_callbacks
  end
end
