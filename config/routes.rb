Rails.application.routes.draw do
    # Defines the root path route ('/')
    root 'articles#index'
    
    resources :profiles
    resources :articles
    resources :users, except: [:new]
    resources :profiles, only: [:show, :edit, :update]
    
    get 'register', to: 'users#new'
    post 'register', to: 'users#create'

    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'

    get 'password/reset', to: 'password_resets#new'
    post 'password/reset', to: 'password_resets#create'

    get 'password/reset/edit', to: 'password_resets#edit'
    patch 'password/reset/edit', to: 'password_resets#update'
    
    get '/uploads/presigned_url', to: 'uploads#presigned_url'
end