class Subject < ApplicationRecord 
	belongs_to :teacher, required: true
	validates :name, presence: true
end