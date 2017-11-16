class CreateStudentsAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :student_answers do |t|
      t.integer :student_id	  , null: false 
      t.integer :question_id  , null: false
      t.text 		:response			, null: false
      t.integer :teacher_score, null: false
      t.integer :system_score , null: false

      t.timestamps
    end

    add_index :student_answers, :student_id
    add_index :student_answers, :question_id
  end
end
