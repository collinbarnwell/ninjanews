class CreateArticleScore < ActiveRecord::Migration
  def change
    create_table :article_scores do |t|
      t.float :score
      t.belongs_to :user
      t.belongs_to :article
      
      t.timestamps
    end
  end
end
