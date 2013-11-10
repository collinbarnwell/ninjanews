class CreateArticleReads < ActiveRecord::Migration
  def change
    create_table :article_reads do |t|
      t.belongs_to :user
      t.belongs_to :article
    end
  end
end
