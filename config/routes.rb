Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/links', to: 'links#index'
      post '/links', to: 'links#create'
      get '/links/:slug', to: 'links#show'
    end
  end
end
