class CreateExamQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :exam_questions do |t|
      t.integer :exam_id, null: false
      t.integer :question_id, null: false

      t.timestamps
    end
  end
end
