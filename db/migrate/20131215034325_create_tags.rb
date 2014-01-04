class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :title
      t.timestamps
    end

    create_table :subscriptions do |t|
      t.belongs_to :user
      t.belongs_to :tag
      t.timestamps
    end

    create_table :articles_tags, id: false do |t|
      t.belongs_to :tag
      t.belongs_to :article
    end
  end
end
