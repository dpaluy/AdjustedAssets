AdjustedAssets::Application.routes.draw do

  resources :portfolios

  resources :settings

  root :to => "home#index"

  devise_for :users
  resources :users, :only => :show

end
