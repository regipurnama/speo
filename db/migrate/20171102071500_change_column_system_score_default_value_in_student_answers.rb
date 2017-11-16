class ChangeColumnSystemScoreDefaultValueInStudentAnswers < ActiveRecord::Migration[5.1]
  def change
  	change_column_default :student_answers, :system_score, 0
  end
end
