Rails.application.routes.draw do
  devise_for :users

  root "application#home"

  get '/users/:user_id/games' => 'games#index', as: 'list_games'

  post '/games/hangman/new' => 'hangman#create', as: 'new_hangman'
  get  '/games/hangman/:id' => 'hangman#show', as: 'hangman_show'
  post '/games/hangman/:id' => 'hangman#move', as: 'hangman_guess'
end
