require 'rest_client'
require 'pry'
require 'json'

def get_subreddits
  parsed_response = JSON.load(RestClient.get("http://reddit.com/reddits.json"))
  parsed_response["data"]["children"].collect do |subreddit|
    subreddit["data"]["url"]
  end
end

p get_subreddits
p get_subreddits.class
