class Story < ActiveRecord::Base
  
  require 'rest_client'
  require 'json'

  validates :title, :link, :category, :upvotes, presence: true
  validates :title, :link, uniqueness: true

  scope :popular, -> { where('upvotes >= ?', 4)}
  scope :recent, -> { where('created_at >= ?', Date.today)}

  belongs_to :user
  has_many :comments
  has_many :commenters, through: :comments, source: :user

  def self.search_for(query)
    where('title LIKE :query OR category LIKE :query', query: "%#{query}%")
  end

  def self.get_remote_stories(subreddit="r/worldnews")
    parsed_response = JSON.load(RestClient.get("http://reddit.com/#{subreddit}.json"))
    parsed_response["data"]["children"].collect do |reddit|
      { title: reddit["data"]["title"], category: reddit["data"]["subreddit"], link: reddit["data"]["url"], upvotes: reddit["data"]["ups"] }
    end
  end


end
