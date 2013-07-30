class StoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def index
    @stories = Story.all
  end

  def show
    @story = Story.find params[:id]
    @comment = @story.comments.new
  end
  
  def store_from_reddit
    @story = Story.get_remote_stories.collect do |reddit|
      {title: reddit[:title], link: reddit[:link], upvotes: reddit[:upvotes], category: reddit[:category]}
      end
    @story = current_user.stories.build(story_params)
    if @story.save
      redirect_to @story
    else
      render :index
    end
  end

  def new
    @story = Story.new
  end

  def create
    @story = current_user.stories.build(story_params)
    @story.upvotes = 1
    if @story.save
      redirect_to @story
    else
      render :new
    end
  end

  def search
    @stories = Story.search_for params[:q]
  end


private

  def story_params
    params.require(:story).permit(:title, :link, :category)
  end

end