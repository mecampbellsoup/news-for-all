require 'rest_client'
require 'pry'
require 'json'

  def get_remote_stories(subreddit="r/worldnews")
    parsed_response = JSON.load(RestClient.get("http://reddit.com/#{subreddit}.json"))
    parsed_response["data"]["children"].collect do |reddit|
      { title: reddit["data"]["title"], category: reddit["data"]["subreddit"], link: reddit["data"]["url"], upvotes: reddit["data"]["ups"] }
    end
  end

p get_remote_stories
