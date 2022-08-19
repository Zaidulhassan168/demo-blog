Rails.application.routes.draw do
  devise_for :users # , controllers: { sessions: 'users/sessions' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  

  # Defines the root path route ("/")
  root 'posts#index'

  # get 'posts/showByUser' => 'posts#showByUser'
  get 'show_by_user', action: :show_by_user, controller: 'posts'

  resources :posts do
    resources :comments
  end


end