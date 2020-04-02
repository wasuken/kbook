Rails.application.routes.draw do
  get 'journals/index'
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :journals, only: [:index, :create, :destroy]
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
