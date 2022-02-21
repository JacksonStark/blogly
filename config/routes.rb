Rails.application.routes.draw do
    # Defines the root path route ("/")
    root 'articles#index'

    resources :articles
    resources :users
    
    post "sign_up", to: "users#create"
    get "sign_up", to: "users#new"

    get '/uploads/presigned_url', to: 'uploads#presigned_url'
end
