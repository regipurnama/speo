class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :recoverable, :rememberable,
         :trackable, :validatable

  has_one :student
  has_one :teacher
end
