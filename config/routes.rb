require "resque_web"

Rails.application.routes.draw do
  get 'help', to: 'help#index'

  root 'welcome#index'

  resources :accounts do
    put 'games/:game_id', to: 'games#play_game', as: 'play_game'
  end

  resources :games, only: [:index, :new, :create]

  devise_for :users

  resque_web_constraint = lambda do |request|
    current_user = request.env['warden'].user
    is_admin = current_user.present? && current_user.respond_to?(:admin?) && current_user.admin?
    request.remote_ip == '127.0.0.1' || request.remote_ip == '::1' || is_admin
  end

  # Resque Web
  constraints resque_web_constraint do
    mount ResqueWeb::Engine => "/resque_web"
    ResqueWeb::Engine.eager_load!
  end
end
