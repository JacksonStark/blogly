Rails.application.routes.draw do
    # Defines the root path route ("/")
    root 'articles#index'

    resources :articles

    get '/uploads/presigned_url', to: 'uploads#presigned_url'
end
