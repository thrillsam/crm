Rails.application.routes.draw do
  resources :tickets do 
    collection do
      get :chart
    end 
  end

  resources :users

  post '/auth/login', to: "authentication#login"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
