Rails.application.routes.draw do
  resources :topics do
    resources :posts do
      resources :comments
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#index"
  # Defines the root path route ("/")
  # root "articles#index"
end
