class Teacher < ApplicationRecord 
	
	validates :name, presence: true
	validates :gender, :inclusion => { :in => GENDER_OPTIONS.map {|o| o[1]} }
	validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end