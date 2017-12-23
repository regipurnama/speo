class AddScoreToStudentAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :student_answers, :quality         , :float , after: :exam_question_id
    add_column :student_answers, :score           , :string, after: :exam_question_id
    add_column :student_answers, :tri_gram_weight , :float , after: :exam_question_id
    add_column :student_answers, :bi_gram_weight  , :float , after: :exam_question_id
    add_column :student_answers, :uni_gram_weight , :float , after: :exam_question_id
  end
end
