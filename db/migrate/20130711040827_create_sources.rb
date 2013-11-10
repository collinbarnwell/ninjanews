class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :title
      t.string :url
      t.string :area
      t.datetime :published_at

      t.timestamps
    end
  end
end
