Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  root 'home#top'
  get 'home/about' => 'home#about'
end


