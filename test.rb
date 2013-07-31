require 'rest_client'
require 'pry'
require 'json'

  def get_remote_stories opts={:type => nil, :id => "r/worldnews"}
    parsed_response = JSON.load(RestClient.get("http://reddit.com/#{opts[:id]}/#{opts[:type]}.json"))
    parsed_response["data"]["children"].collect do |reddit|
      { title: reddit["data"]["title"], category: reddit["data"]["subreddit"], link: reddit["data"]["url"], upvotes: reddit["data"]["ups"] }
    end
  end

p get_remote_stories
p get_remote_stories.class
