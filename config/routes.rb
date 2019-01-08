Simpler.application.routes do
  get '/tests', 'tests#index'
  get '/tests/:category/:id', 'tests#show'
  post '/tests', 'tests#create'
end
