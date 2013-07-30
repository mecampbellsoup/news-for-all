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
    Story.get_remote_stories.each do |reddit|
      @story = Story.new({title: reddit[:title], link: reddit[:link], upvotes: reddit[:upvotes], category: reddit[:category]})
      @story.save
      #rescue statement to ensure the loop always finishes
      #if it breaks display the error
      #but move this all to the model
      end
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

  def destroy
    @story = Story.find(params[:id])
    if @story.present?
      @story.destroy
      flash[:notice] = "The story with link '#{@story.link}' has been removed"
    end
    redirect_to :action => 'index'
  end


private

  def story_params
    params.require(:story).permit(:title, :link, :category)
  end

end