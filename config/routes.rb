Rails.application.routes.draw do
    # Defines the root path route ("/")
    root 'articles#index'
    
    resources :profiles
    resources :articles
    resources :users, except: [:new]
    resources :profiles, only: [:show, :edit, :update]
    
    get "register", to: "users#new"

    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"
    
    get '/uploads/presigned_url', to: 'uploads#presigned_url'
end