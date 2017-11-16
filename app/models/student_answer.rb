class StudentAnswer < ApplicationRecord 
	attr_accessor :answer_term_frequency

	belongs_to :student , required: true
	belongs_to :question, required: true

end