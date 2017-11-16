class Question < ApplicationRecord 
	belongs_to :subject, required: true

	has_many :student_answers

	validates :title, presence: true
	validates :key, presence: true
end