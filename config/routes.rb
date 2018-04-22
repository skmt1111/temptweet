Rails.application.routes.draw do
  get 'tweet', to: 'tweet#new', as: :tweet
  get '/', to: 'top#index', as: :top

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: :logout

  root 'top#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
