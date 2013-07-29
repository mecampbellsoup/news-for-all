class Story < ActiveRecord::Base
  validates :title, :link, :category, :upvotes, presence: true
  scope :popular, -> { where('upvotes >= ?', 4)}
  scope :recent, -> { where('created_at >= ?', Date.today)}

  belongs_to :user
  has_many :comments
  has_many :commenters, through: :comments, source: :user

  def self.search_for(query)
    where('title LIKE :query OR category LIKE :query', query: "%#{query}%")
  end

  def self.get_remote_stories(type=nil, sr="worldnews")
    response = RestClient.get("http://reddit.com/r/#{sr}/#{type}.json")
    parsed_response = JSON.load(response)
    parsed_response["data"]["children"].map do |reddit|
      { title: reddit["data"]["title"], category: reddit["data"]["subreddit"], link: reddit["data"]["url"] }
    end
  end

end
