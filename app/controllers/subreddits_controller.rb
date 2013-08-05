class SubredditsController < ApplicationController  
  before_action :authenticate_user!, only: [:new, :reddit_stories]

  def new
    @subreddits = Subreddit.get_subreddits.collect do |subreddit|
      @subreddit = Subreddit.new({name: subreddit[:name], image: subreddit[:image], subreddit: subreddit[:subreddit]})
      if @subreddit.save
        @subreddit
      else
        @subreddit.destroy
      end 
    end
  end

  def reddit_stories
    @stories = Story.get_remote_stories(Subreddit.find(params[:id])[:subreddit]).collect do |reddit|
      @story = Story.new({title: reddit[:title], link: reddit[:link], upvotes: reddit[:upvotes], category: reddit[:category], user_id: current_user.id})
      if @story.save
        @story
      else
        @story.destroy
      end
    end
    redirect_to stories_path
    #rescue statement to ensure the loop always finishes
    #if it breaks display the error
    #but move this all to the model
    
  end
  
# private

#   def subreddit_params
#     params.require(:subreddit).permit(:name, :image, :subreddit)
#   end

end