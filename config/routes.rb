Rails.application.routes.draw do
  resources :topics do
    resources :posts do
      resources :ratings, only: [:create]
      resources :comments
    end
  end
  resources :tags do
  member do
    get 'posts', to: 'tags#posts', as: 'posts'
  end
  end
  get 'all_posts',to: 'posts#all_posts'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#index"
  # Defines the root path route ("/")
  # root "articles#index"
end
