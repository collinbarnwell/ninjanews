class CreateTagRelations < ActiveRecord::Migration
  def change
    create_table :tag_relations do |t|
      t.float :score
      t.integer :tag_1_id
      t.integer :tag_2_id

      t.timestamps
    end
  end
end
