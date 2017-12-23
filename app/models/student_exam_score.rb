# == Schema Information
#
# Table name: student_exam_scores
#
#  id         :integer          not null, primary key
#  student_id :integer          not null
#  exam_id    :integer          not null
#  score      :string(255)
#  quality    :float(24)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StudentExamScore < ApplicationRecord
  belongs_to :student
  belongs_to :exam
end
