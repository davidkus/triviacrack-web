require "resque_web"

Rails.application.routes.draw do
  get 'help', to: 'help#index'

  root 'welcome#index'

  resources :accounts do
    put 'games/:game_id', to: 'games#play_game', as: 'play_game'
  end

  resources :games, only: [:index, :new, :create]

  devise_for :users

  # Resque Web
  resque_web_constraint = lambda { |request| request.remote_ip == '127.0.0.1' }
  constraints resque_web_constraint do
    mount ResqueWeb::Engine => "/resque_web"
    ResqueWeb::Engine.eager_load!
  end
end
