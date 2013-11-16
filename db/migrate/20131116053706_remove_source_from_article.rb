class RemoveSourceFromArticle < ActiveRecord::Migration
  def change
    remove_column :articles, :source_id
  end
end
