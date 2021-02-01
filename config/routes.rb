Rails.application.routes.draw do
  resources :recipes, only: [:index, :show]
  root to: 'recipes#index'
end
