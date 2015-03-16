Rails.application.routes.draw do
  devise_for :users

  root "application#home"

  resources :tictactoes, only: [:show, :index, :create, :update, :new]
end
