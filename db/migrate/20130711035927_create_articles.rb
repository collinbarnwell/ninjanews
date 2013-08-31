class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :image
      t.string :content
      t.string :source
      t.string :url
      t.string :section

      t.timestamps
    end
  end
end
