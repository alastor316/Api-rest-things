include Swagger::Docs::ImpotentMethods
Rails.application.routes.draw do
 # devise_for :users
 #  require 'sidekiq/web'
Swagger::Docs::Config.base_api_controller = ActionController::API
mount SwaggerUiEngine::Engine, at: "/api_docs"

 # mount RedisBrowser::Web => '/redis-browser'
 # mount Sidekiq::Web => '/sidekiq'
 
 root to: 'login#login'

 namespace :api, constraints: { format: 'json' }  do

 	  resources :medidores 
 	  resources :usuarios do
 	   member do
    		get 'medidores'
  	   end
 	   collection do
    	   get 'last_user'
    	   get 'medidores'
    	   #get 'first_user'
    	   #get 'other_user'  
  	   end
 	  end

 	  
      post   "/sign-in"       => "sessions#create"
      delete "/sign-out"      => "sessions#destroy"

 	  post '/estadophinet' => 'estado#estadophinet' 
 	  post '/data' => 'data#data' 
 	  get '/data/estado' => 'data#dataestado' 
 	  get '/data/conectarse' => 'data#dataconectarse' 
 	  get '/data/historico' => 'data#datahistorico'

end


 


end
