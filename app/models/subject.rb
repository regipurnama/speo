# == Schema Information
#
# Table name: subjects
#
#  id         :integer          not null, primary key
#  teacher_id :integer          not null
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Subject < ApplicationRecord 
	belongs_to :teacher, required: true
	validates :name, presence: true
end
