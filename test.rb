require 'rest_client'
require 'pry'
require 'json'

  def get_subreddits
    parsed_response = JSON.load(RestClient.get("http://reddit.com/reddits.json"))
    parsed_response["data"]["children"].each_with_index.collect do |subreddit,i|
      { subreddit: subreddit["data"]["url"], image: subreddit["data"]["header_img"], name: subreddit["data"]["display_name"], id: i }
    end
  end

p get_subreddits
