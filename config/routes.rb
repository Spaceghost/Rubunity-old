Rubunity::Application.routes.draw do
  resources :conferences

  root :to => "pages#home"

  resources :comments

  resources :bookmarks do
    match "add_topic" => "bookmarks#add_topic"
    match "add_rails_version", :as => "add_rails_version"
    match "add_ruby_version", :as => "add_ruby_version"
    
    get :add_topic
    post :add_topic
     
    resources :comments
  end
  
  # votes
  match "bookmark/vote/:bookmark", :to => "bookmarks#vote"

  resources :users, :user_sessions

  match "login" => "user_sessions#new", :as => "login"
  match "logout" => "user_sessions#destroy", :as => "logout"
  match "register" => "users#new", :as => "register"
  
  match "settings" => "users#settings", :as => "settings"
  
  match "search" => "search#query", :as => "search"
  
  #pages
  match "botusage" => "pages#irc_bot_usage", :as => "bot_usage"

  # admin
  match 'admin' => 'admin#index', :as => :admin
  scope "/admin" do
    resources :users
  end
end
