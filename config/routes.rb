Rails.application.routes.draw do

  root 'sessions#index'

  get '/users/:id' => 'users#show'

  get '/events/in30sec' => 'events#in30sec'

  post '/users' => 'users#login'

  post '/sessions' => 'sessions#create'

  post '/events' => 'events#create' # creating new event

  delete '/events/:id' => 'events#destroy' #destroy event
  
  delete '/sessions' => 'sessions#destroy'

end
