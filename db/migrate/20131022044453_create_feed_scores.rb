class CreateFeedScores < ActiveRecord::Migration
  def change
    create_table :feed_scores do |t|
      t.belongs_to :feed
      t.belongs_to :user
      t.float :score

      t.timestamps
    end
  end
end
