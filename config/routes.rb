Rails.application.routes.draw do
  resources :notes
  resources :collections
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :strains, only: [:index, :show]
end
