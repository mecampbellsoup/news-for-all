class Subreddit < ActiveRecord::Base

  require 'rest_client'
  require 'json'

  validates :subreddit, :name, :image, presence: true, uniqueness: true

  belongs_to :user

  def self.get_subreddits
    parsed_response = JSON.load(RestClient.get("http://reddit.com/reddits.json"))
    parsed_response["data"]["children"].each_with_index.collect do |subreddit,i|
      { subreddit: subreddit["data"]["url"], image: subreddit["data"]["header_img"], name: subreddit["data"]["display_name"] }
    end
  end

end
