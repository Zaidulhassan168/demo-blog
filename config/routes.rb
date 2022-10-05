Rails.application.routes.draw do
  # mount ActionCable.server => '/wssocket'
  # if Rails.env.development? || Rails.env.staging?
  #   mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  # end
  # mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?
  # post '/graphql', to: 'graphql#execute'
  # post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # mount DemoBlog::Base => ‘/’

  #  mount Root => '/'
  # Defines the root path route ("/")
  root 'posts#index'

  # get 'posts/showByUser' => 'posts#showByUser'
  get 'show_by_user', action: :show_by_user, controller: 'posts'
  get 'top_rated_posts', action: :top_rated_posts, controller: 'posts'
  get 'rating', action: :rating, controller: 'posts'
  resources :posts do
    resources :comments
  end
end
