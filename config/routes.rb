Rewsly::Application.routes.draw do
  devise_for :users
  root 'stories#index'
  resources :stories do
    resources :comments, only: :create
  end
  get 'search', to: 'stories#search'
  get 'stories/new/reddit', to: 'stories#reddits'
  get 'stories/new/subreddit', to: 'stories#subreddits'
end
