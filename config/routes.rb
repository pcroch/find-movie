Rails.application.routes.draw do
  devise_for :users , skip: :all
  root to: 'pages#home'
# root to: 'api/v1/finders#index'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :finders, only: [ :index, :show, :update, :create, :destroy ]
      resources :preferences, only: [:index, :show, :update, :create, :destroy]
      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
      end
    end
  end



end
