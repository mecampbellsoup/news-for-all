Rewsly::Application.routes.draw do
  devise_for :users
  root 'stories#index'
  resources :stories do
    resources :comments, only: :create
  end
  get 'search', to: 'stories#search'
  get 'stories/new/reddit/:id', to: 'stories#display_reddits', as: :reddit_add
  get 'stories/new/subreddit', to: 'stories#subreddits'
end
