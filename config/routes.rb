Rewsly::Application.routes.draw do
  devise_for :users
  root 'stories#index'
  resources :stories do
    resources :comments, only: :create
  end
  get 'search', to: 'stories#search'
  get 'stories/new/remote_add', to: 'stories#store_from_reddit'
end
