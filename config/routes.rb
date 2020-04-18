Rails.application.routes.draw do

  resources :tags
  get "/search" => "pages#search", :as => "search_page"
  resources :users
  get "/signup", to: "users#new", as: "signup"



  root to:"strains#index"
  
  get "collections/homepage", to: "collections#index", as: "homepage"
  get "collections/results", to: "collections#results", :as => "collection_results"
  get "collections/sativas", to: "collections#sativas", :as => "sativas"
  get "collections/hybrids", to: "collections#hybrids", :as => "hybrids"
  get "collections/indicas", to: "collections#indicas", :as => "indicas"
  get "collections/positives", to: "collections#positives", :as => "positive"
  get "collections/medicinal", to: "collections#medicinal", :as => "medicinal"
  get "collections/flavors", to: "collections#flavors", :as => "flavor"
  get "collections/view_all", to: "collections#view_all", as: "view_all"
  post "collections/filter_results", to: "collections#result", as: "results"

  get "collections/matches/:attribute", to: "collections#matches", :as => "match"
  post "strains/add_comment", to: "comments#create", :as => "add_comment"
  get "strains/add_like/:id", to: "strains#add_like", :as => "add_like"
  resources :collections, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :notes
  
  resources :strains, only: [:index, :show]

 
  get "/login", to: "auth#new", :as => "login"
  post "/login", to: "auth#create"
  post "/logout", to: "auth#logout", :as => "logout"
  get "/deny", to: "auth#deny", :as => "deny"
  post "/add_to_collections", to: "collections#add_to_collection", :as => "add_to_collections"
  get "/incompleted", to: "collections#incompleted", :as => "incompleted"
  



end
