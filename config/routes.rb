Rails.application.routes.draw do

  namespace :api, default: { format: :json } do
    namespace :v1 do
      post "register", to: 'sessions#register', as: "register", format: :json
      post "login", to: 'sessions#login', as: "login", format: :json
      resources :accounts, except: [:update] do
        resources :transactions, only: [:index, :show, :create]
      end
    end
  end
end
