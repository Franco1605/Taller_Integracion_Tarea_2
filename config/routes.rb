Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'hamburguesa' => 'hamburgers#index'
      get 'hamburguesa/:id' => 'hamburgers#show' 
      post 'hamburguesa' => 'hamburgers#create'
      put 'hamburguesa/:id_hamburguesa/ingrediente/:id_ingrediente' => 'hamburgers#add_ingredient'
      patch 'hamburguesa/:id' => 'hamburgers#edit_hamburger'
      delete 'hamburguesa/:id' => 'hamburgers#destroy'
      delete 'hamburguesa/:id_hamburguesa/ingrediente/:id_ingrediente'=> 'hamburgers#delete_ingredient'
      get 'ingrediente' => 'ingredients#index'
      get 'ingrediente/:id' => 'ingredients#show' 
      post 'ingrediente' => 'ingredients#create'
      delete 'ingrediente/:id' => 'ingredients#destroy'
    end
  end
end
