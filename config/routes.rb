Rails.application.routes.draw do
  root to: "organizations#index"
  devise_for :users
  resources :organizations do
    resources :quizzes do
      resources :ratings, only: [:create]
      resources :questions do
        resources :choices
      end
    end
  end
  resources :tags
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end