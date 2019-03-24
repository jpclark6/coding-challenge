Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/', to: 'main#index'
      get '/links', to: 'links#index'
      post '/links', to: 'links#create'
      get '/links/:slug', to: 'links#show'
      put '/links/:slug', to: 'links#update'
      delete '/links/:slug', to: 'links#destroy'
    end
  end
end
