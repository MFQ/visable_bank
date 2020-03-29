Rails.application.routes.draw do

  namespace :api, default: { format: :json } do
    namespace :v1 do
      post "register", to: 'sessions#register', as: "register", format: :json
      post "login", to: 'sessions#login', as: "login", format: :json
    end
  end
end
