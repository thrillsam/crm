Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/your/endpoint"
  end
  post "/graphql", to: "graphql#execute"
  resources :tickets do
    collection do
      get :chart
    end
  end

  resources :users

  post '/auth/login', to: "authentication#login"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
