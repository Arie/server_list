ServerList::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "sessions" }

  devise_scope :user do
    get '/sessions/auth/:provider' => 'sessions#passthru'
    post '/users/auth/:provider/callback' => 'sessions#steam'
    get '/users/auth/:provider/callback' => 'sessions#steam'
    delete "/users/logout" => "devise/sessions#destroy"
  end

  resources :sessions do
    collection do
      get :steam
      post :passthru
      get :failure
    end
  end

  resources :servers

  resources :users do
    collection do
      get :edit
      post :update
    end
  end

  get   '/login', :to => 'sessions#new',  :as => :login
  match '/users/auth/failure',            :to => 'sessions#failure'

  root :to => "servers#index"
end
