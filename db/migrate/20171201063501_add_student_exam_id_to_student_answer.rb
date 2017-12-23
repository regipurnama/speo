class AddStudentExamIdToStudentAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :student_answers, :exam_question_id, :integer, after: :question_id
  end
end
