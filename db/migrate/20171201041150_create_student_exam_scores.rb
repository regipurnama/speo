class CreateStudentExamScores < ActiveRecord::Migration[5.1]
  def change
    create_table :student_exam_scores do |t|
      t.integer :student_id, null: false
      t.integer :exam_id   , null: false
      t.string  :score     , null: true
      t.float   :quality   , null: true

      t.timestamps
    end
  end
end
