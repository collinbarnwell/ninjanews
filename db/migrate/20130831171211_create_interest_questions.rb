class CreateInterestQuestions < ActiveRecord::Migration
  def change
    create_table :interest_questions do |t|
      t.text :question_text

      t.timestamps
    end
  end
end
