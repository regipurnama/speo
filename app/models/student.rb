class Student < ApplicationRecord 
	belongs_to :grade, required: true

	validates :name, presence: true
	validates :gender, :inclusion => { :in => GENDER_OPTIONS.map {|o| o[1]} }
end