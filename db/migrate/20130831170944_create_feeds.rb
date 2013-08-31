class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.belongs_to :source
      t.string :url
      t.string :section
      t.integer :area_importance
      t.boolean :is_local_news, default: false

      t.timestamps
    end

    change_table :articles do |t|
      t.belongs_to :source
    end
  end
end
