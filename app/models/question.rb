# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  subject_id :integer          not null
#  title      :string(255)      not null
#  key        :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ApplicationRecord
	belongs_to :subject, required: true

	has_many :student_answers
  has_many :exam_questions
  has_many :students, through: :student_answers

	validates :title, presence: true
	validates :key, presence: true
end
