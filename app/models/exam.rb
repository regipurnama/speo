# == Schema Information
#
# Table name: exams
#
#  id          :integer          not null, primary key
#  title       :string(255)      not null
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Exam < ApplicationRecord
  validates :title, presence: true

  has_many :exam_questions, dependent: :destroy
  has_many :questions, through: :exam_questions
  has_many :student_answers, through: :exam_questions

  has_many :student_exam_scores, dependent: :destroy
  has_many :students, through: :student_exam_scores

  def calculate_quality_and_score!
    scores = { "A" => 4.0, "B" => 3.0, "C" => 2.0, "D" => 1.0 }
    highest_possible_score = exam_questions.count * 4
    grouped_student_answers = student_answers.to_a.group_by{|sa| sa.student_id}

    student_exam_scores.each do |student_exam_score|
      student_scores = grouped_student_answers[student_exam_score.student_id].map(&:score)
      student_exam_score.quality = (student_scores.map{|s| scores[s]}.sum/highest_possible_score) * 100
      student_exam_score.save
    end
  end
end
