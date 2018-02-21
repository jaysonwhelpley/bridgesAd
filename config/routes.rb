Rails.application.routes.draw do
  root to: 'pages#main'
  resources :bases
  resources :codes do
    member do
      get :merged
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
