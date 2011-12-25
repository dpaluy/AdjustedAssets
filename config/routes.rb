AdjustedAssets::Application.routes.draw do

  resources :portfolios do
    resources :asset_actions
    resources :option_actions
  end

  resources :settings

  root :to => "home#index"

  devise_for :users
  resources :users, :only => :show

end
