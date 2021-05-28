Rails.application.routes.draw do
  get '/', to: 'application#welcome'
  
  namespace :admin do
    resources :shelters, only: [:index, :show]
    resources :applications, only: [:show]
  end

  resources :shelters

  resources :pets, except: [:new, :create]

  resources :applications, except: [:destroy]

  resources :veterinary_offices 

  resources :veterinarians, except: [:create]

  resources :shelters do
    get '/pets', to: 'shelters#pets'
    resources :pets, only: [:new, :create] 
  end

  resources :veterinary_offices do
    get '/veterinarians', to: 'veterinary_offices#veterinarians'
    resources :veterinarians, only: [:new, :create] 
  end

  post 'pet_applications', to: 'pet_applications#create'
  patch 'pet_applications', to: 'pet_applications#update'
end
