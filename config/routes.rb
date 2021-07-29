Rails.application.routes.draw do
  # resources :items, only: [:index]
  # resources :users, only: [:show]

  #GET /users/:user_id/items
  resources :items, only: [:index]
  resources :users, only: [:show] do
    resources :items, only: [:index, :show, :create]
  end

end

# GET   /dog_houses/:dog_house_id/reviews               reviews#index
# GET   /dog_houses/:dog_house_id/reviews/:id           reviews#show 