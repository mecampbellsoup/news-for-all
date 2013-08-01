class CreateSubreddits < ActiveRecord::Migration
  def change
    create_table :subreddits do |t|
      t.string :subreddit
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
