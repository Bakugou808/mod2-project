Rails.application.routes.draw do

  resources :users
  get "/signup", to: "users#new", as: "signup"



  resources :strains, only: [:index, :show]
  root to:"strains#index"
  get "collections/homepage", to: "collections#index", as: "homepage"
  resources :collections, only: [:new, :create, :show, :edit, :update, :delete]
  resources :notes

  get "/search" => "pages#search", :as => "search_page"
  get "/login", to: "auth#new"
  post "/login", to: "auth#create"
  
end
