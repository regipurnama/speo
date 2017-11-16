class ChangeTeacherScoreAndSystemScoreTypeDataInStudentsAnswers < ActiveRecord::Migration[5.1]
  def change
  	change_column :student_answers, :teacher_score, :float
  	change_column :student_answers, :system_score, :float  	
  end
end
