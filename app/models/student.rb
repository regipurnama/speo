# == Schema Information
#
# Table name: students
#
#  id         :integer          not null, primary key
#  grade_id   :integer          not null
#  name       :string(255)      not null
#  gender     :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Student < ApplicationRecord 
	belongs_to :grade, required: true

	validates :name, presence: true
	validates :gender, :inclusion => { :in => GENDER_OPTIONS.map {|o| o[1]} }
end
