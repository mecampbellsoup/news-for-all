class StoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
    @stories = Story.all
  end

  def show
    @story = Story.find params[:id]
    @comment = @story.comments.new
  end

  def new
    @story = Story.new
  end

  def create
    safe_story_params = params.require(:story).permit(:title, :link, :category)
    @story = current_user.stories.build safe_story_params
    @story.upvotes = 1
    if @story.save
      redirect_to @story
    else
      render :new
    end
  end

  # def remote_stories(type:"hot", sr:"politics")
  #   response = RestClient.get("http://reddit.com/r/#{sr}/#{type}.json")
  #   parsed_response = JSON.load(response)
  #   parsed_response["data"]["children"].map do |reddit|
  #     @story = { title: reddit["data"]["title"], category: reddit["data"]["subreddit"], upvotes:  }
  #   end
  # end

  def search
    @stories = Story.search_for params[:q]
  end
end
