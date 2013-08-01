class AddUserAssociationToSubreddits < ActiveRecord::Migration
  def change
        add_reference :subreddits, :user, index: true
  end
end
