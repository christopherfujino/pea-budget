Rails.application.routes.draw do
  root to: 'website#index'

  get 'csvs/new'
  post 'csvs/create'
  get 'csvs', to: 'csvs#index'
  get 'csvs/:csv_id', to: 'csvs#show', as: 'csvs_show'
  patch 'csvs/:csv_id', to: 'csvs#update'
  delete 'csvs/:csv_id', to: 'csvs#destroy', as: 'csvs_destroy'

  post 'accounts/create'
  get 'accounts', to: 'accounts#index'
  get 'accounts/:account_id', to: 'accounts#show', as: 'accounts_show'
  patch 'accounts/:account_id', to: 'accounts#update'
  delete 'accounts/:account_id', to: 'accounts#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
