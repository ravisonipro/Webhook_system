Rails.application.routes.draw do
  resources :payments
  post 'webhooks/receive'
end
