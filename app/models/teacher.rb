# == Schema Information
#
# Table name: teachers
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  gender     :string(255)      not null
#  email      :string(255)      not null
#  contact    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Teacher < ApplicationRecord 
	
	validates :name, presence: true
	validates :gender, :inclusion => { :in => GENDER_OPTIONS.map {|o| o[1]} }
	validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end
