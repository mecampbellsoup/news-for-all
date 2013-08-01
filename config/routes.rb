Rewsly::Application.routes.draw do
  devise_for :users

  root 'stories#index'
  resources :stories do
    resources :comments, only: :create
  end
  get 'search', to: 'stories#search'
  
  post 'reddit/save/', to: 'stories#create', as: :reddits_save
  get 'subreddit/new/', to: 'subreddits#new', as: :subred_list
  get 'subreddit/new/:id/stories', to: 'subreddits#reddit_stories', as: :reddits

end
