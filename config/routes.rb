Rails.application.routes.draw do
  resources :tacos

  root to: "tacos#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
