class Role < ApplicationRecord
  has_many :enrollments
  validates :name, presence: true, uniqueness: true
end
