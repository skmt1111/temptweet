Rails.application.routes.draw do
  get '/', to: 'top#index', as: :top
  get 'tweet', to: 'tweet#new', as: :tweet_new
  post 'tweet/create', to: 'tweet#create', as: :tweet
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: :logout

  root 'top#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
