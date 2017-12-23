# == Schema Information
#
# Table name: exam_questions
#
#  id          :integer          not null, primary key
#  exam_id     :integer          not null
#  question_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ExamQuestion < ApplicationRecord
  belongs_to :exam
  belongs_to :question

  has_many :student_answers

  delegate :title, to: :question, allow_nil: true
end
