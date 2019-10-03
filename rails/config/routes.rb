# == Route Map
#
#                                Prefix Verb   URI Pattern                                                                              Controller#Action
#                      transactions_new GET    /transactions/new(.:format)                                                              transactions#new
#                   transactions_create GET    /transactions/create(.:format)                                                           transactions#create
#                          transactions GET    /transactions(.:format)                                                                  transactions#index
#                   transactions_update GET    /transactions/update(.:format)                                                           transactions#update
#                  transactions_destroy GET    /transactions/destroy(.:format)                                                          transactions#destroy
#                     transactions_show GET    /transactions/show(.:format)                                                             transactions#show
#                                  root GET    /                                                                                        website#index
#                              csvs_new GET    /csvs/new(.:format)                                                                      csvs#new
#                           csvs_create POST   /csvs/create(.:format)                                                                   csvs#create
#                                  csvs GET    /csvs(.:format)                                                                          csvs#index
#                             csvs_show GET    /csvs/:csv_id(.:format)                                                                  csvs#show
#                                       PATCH  /csvs/:csv_id(.:format)                                                                  csvs#update
#                          csvs_destroy DELETE /csvs/:csv_id(.:format)                                                                  csvs#destroy
#                          accounts_new GET    /accounts/new(.:format)                                                                  accounts#new
#                       accounts_create POST   /accounts/create(.:format)                                                               accounts#create
#                              accounts GET    /accounts(.:format)                                                                      accounts#index
#                         accounts_show GET    /accounts/:account_id(.:format)                                                          accounts#show
#                                       PATCH  /accounts/:account_id(.:format)                                                          accounts#update
#                                       DELETE /accounts/:account_id(.:format)                                                          accounts#destroy
#         rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#create
#         rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                  action_mailbox/ingresses/postmark/inbound_emails#create
#            rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                     action_mailbox/ingresses/relay/inbound_emails#create
#         rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                  action_mailbox/ingresses/sendgrid/inbound_emails#create
#          rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                              action_mailbox/ingresses/mailgun/inbound_emails#create
#        rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#index
#                                       POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#create
#     new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                             rails/conductor/action_mailbox/inbound_emails#new
#    edit_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id/edit(.:format)                        rails/conductor/action_mailbox/inbound_emails#edit
#         rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#show
#                                       PATCH  /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       PUT    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       DELETE /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#destroy
# rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                      rails/conductor/action_mailbox/reroutes#create
#                    rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#             rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                    rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#             update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#                  rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  get 'transactions/new'
  get 'transactions/create'
  get 'transactions', to: 'transactions#index'
  get 'transactions/update'
  get 'transactions/destroy'
  get 'transactions/show'
  root to: 'website#index'

  get 'csvs/new'
  post 'csvs/create'
  get 'csvs', to: 'csvs#index'
  get 'csvs/:csv_id', to: 'csvs#show', as: 'csvs_show'
  patch 'csvs/:csv_id', to: 'csvs#update'
  delete 'csvs/:csv_id', to: 'csvs#destroy', as: 'csvs_destroy'

  get 'accounts/new'
  post 'accounts/create'
  get 'accounts', to: 'accounts#index'
  get 'accounts/:account_id', to: 'accounts#show', as: 'accounts_show'
  patch 'accounts/:account_id', to: 'accounts#update'
  delete 'accounts/:account_id', to: 'accounts#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
