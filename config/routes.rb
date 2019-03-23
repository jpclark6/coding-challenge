Rails.application.routes.draw do
  get '/', to: 'links#index'
  

  namespace :api do
    namespace :v1 do
      get '/', to: 'main#index'
      get '/links', to: 'links#index'
      post '/links', to: 'links#create'
      get '/links/:slug', to: 'links#show'
      delete '/links/:slug', to: 'links#destroy'
    end
  end
end
