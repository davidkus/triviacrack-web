Rails.application.routes.draw do
  get "help", to: "help#index"

  root "welcome#index"

  resources :accounts do
    put "games/:game_id", to: "games#play_game", as: "play_game"
  end

  resources :games, only: %i[index new create]

  devise_for :users

  authenticate :user, ->(user) { user.admin? } do
    mount GoodJob::Engine => "good_job"
  end
end
