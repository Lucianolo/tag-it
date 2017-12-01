Rails.application.routes.draw do

  
  get "home" => "home#index" 
  
  root "home#index"
  
  get "prodotti" => "home#products", as: :products
  
  post "products/:id/add_review" => "home#add_review"
  
  post "products/add" => "home#add_product"
  
  post "products/delete_product" => "home#delete_product"
  
  post "products/edit" => "home#edit_product"
  
  post "products/add_favorite" => "home#add_favorite"
  
  post "products/delete_favorite" => "home#delete_favorite"
  
  get "dettagli/:id/:tab" => "home#details", as: :details
  
  
  
    devise_for :users
    
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
