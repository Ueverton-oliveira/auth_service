Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'register', to: 'auth#register'
      post 'login', to: 'auth#login'
      get 'validate_token', to: 'auth#validate_token'
    end
  end
end
