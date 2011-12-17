AdjustedAssets::Application.routes.draw do

  resources :settings

  root :to => "home#index"

  devise_for :users
  resources :users, :only => :show

end
