Rails.application.routes.draw do
  root to: 'website#index'

  post 'accounts/create'
  get 'accounts', to: 'accounts#index'
  get 'accounts/:account_id', to: 'accounts#show', as: 'accounts_show'
  patch 'accounts/update'
  delete 'accounts/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
