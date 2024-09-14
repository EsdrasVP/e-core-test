class User < ApplicationRecord
  has_many :enrollments
  has_many :teams, through: :enrollments
end
