Rails.application.routes.draw do
  get 'reciples/index'
  get 'reciples/show'
  root to: 'reciples#index'
end
