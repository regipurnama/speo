# == Schema Information
#
# Table name: high_scores
#
#  id         :integer          not null, primary key
#  game       :string(255)
#  score      :integer
#  level      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class HighScore < ApplicationRecord
end
