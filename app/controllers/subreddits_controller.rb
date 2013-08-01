class SubredditsController < ApplicationController  

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

  def create
    @reddits = Story.new(params[:reddits])
    @reddits.each do |reddit|
      reddit.save
    end
    render 'stories/index'
  end

  def reddit_stories
    @reddits = Story.get_remote_stories(Subreddit.find(params[:id])[:subreddit]).collect do |reddit|
      @reddit = Story.new({title: reddit[:title], link: reddit[:link], upvotes: reddit[:upvotes], category: reddit[:category]})
    end
    #rescue statement to ensure the loop always finishes
    #if it breaks display the error
    #but move this all to the model
    
  end
  
private

  def subreddit_params
    params.require(:subreddit).permit(:name, :image, :subreddit)
  end

end