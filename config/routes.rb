Rails.application.routes.draw do
  devise_for :users

  root "application#home"

  get '/users/:user_id/games' => 'games#index', as: 'list_games'
end
