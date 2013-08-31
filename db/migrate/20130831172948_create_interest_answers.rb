class CreateInterestAnswers < ActiveRecord::Migration
  def change
    create_table :interest_answers do |t|
      t.belongs_to :interest_question
      t.belongs_to :user
      t.integer :interest_rating

      t.timestamps
    end
  end
end
