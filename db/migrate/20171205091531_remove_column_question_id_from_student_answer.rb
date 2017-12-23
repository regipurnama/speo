class RemoveColumnQuestionIdFromStudentAnswer < ActiveRecord::Migration[5.1]
  def change
    remove_column :student_answers, :question_id, Integer
    remove_column :student_answers, :system_score, Integer
  end
end
