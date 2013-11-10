class CreateRelationLevels < ActiveRecord::Migration
  def change
    create_table :relation_levels do |t|
      t.belongs_to :feed
      t.belongs_to :interest_question
      t.integer :score

      t.timestamps
    end
  end
end
