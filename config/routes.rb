Rails.application.routes.draw do
    # Defines the root path route ('/')
    root 'articles#index'
    
    resources :profiles
    resources :articles do
        member do
            put :transition, to: 'articles#transition'
        end
    end
    resources :users, except: [:new]
    resources :profiles, only: [:show, :edit, :update]
    
    get :register, to: 'users#new'
    post :register, to: 'users#create'

    get :login, to: 'sessions#new'
    post :login, to: 'sessions#create'
    delete :logout, to: 'sessions#destroy'

    scope :password, as: :password do 
        get :reset, to: 'password_resets#new'
        post :reset, to: 'password_resets#create'
        get 'reset/edit', to: 'password_resets#edit'
        patch 'reset/edit', to: 'password_resets#update'
    end
    
    get 'uploads/presigned_url', to: 'uploads#presigned_url'
end