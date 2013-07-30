require 'rest_client'
require 'pry'
require 'json'

def remote_stories(type=nil, sr="worldnews")
    response = RestClient.get("http://reddit.com/r/#{sr}/#{type}.json")
    parsed_response = JSON.load(response)
    parsed_response["data"]["children"].map do |reddit|
      @stories = { title: reddit["data"]["title"], category: reddit["data"]["subreddit"], link: reddit["data"]["url"], upvotes: reddit["data"]["ups"] }
    end
  end

p remote_stories
p remote_stories.class
