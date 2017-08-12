Rails.application.routes.draw do
  resources :posts do
    collection {post :search,:more}
  end
  resources :users, only: [:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
  post 'images' => 'photos#images'

  get "login" => "users#login", :as => "login"
  delete "logout" => "users#logout", :as => "logout"
  post "create_login_session" => "users#create_login_session"

end
