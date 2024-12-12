Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'tweets/:tweet_id/likes' => 'likes#create'
  get 'tweets/:tweet_id/likes/:id' => 'likes#destroy'
  resources :tweets
  resources :tweets do
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create]
  end
  resources :lessons
  root 'tweets#index'


  
end
