Rails.application.routes.draw do

  root 'links#index'
  resources :links, only: [:index, :create]
  get ':slug' => 'links#show'

end
