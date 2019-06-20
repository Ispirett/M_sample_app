Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/sign_up', to: 'users#new'
  post  "/sign_up", to: 'users#create'
  get "/login" , to: 'sessions#new', as: 'sessions_new'
  post "/login", to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get  "/home", to: 'static_pages#home'
  get  "/help", to: 'static_pages#help'
  get  "/about", to: 'static_pages#about'
  get  "/contact", to:'static_pages#contact'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 resources :users
end
