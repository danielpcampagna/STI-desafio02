Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "stations/suggests", to: "stations#suggests", defaults: { format: 'json' }
  get "stations/search", to: "stations#search", defaults: { format: 'json' }
  resources :stations
  root 'stations#index'
end
