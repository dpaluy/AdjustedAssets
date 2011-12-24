AdjustedAssets::Application.routes.draw do

  resources :portfolios, :shallow => true do
    resources :asset_actions
  end

  resources :settings

  root :to => "home#index"

  devise_for :users
  resources :users, :only => :show

end
