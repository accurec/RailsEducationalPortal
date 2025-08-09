class Course < ApplicationRecord
  belongs_to :term
  has_many :enrollments, dependent: :destroy
  has_many :users, through: :enrollments
end
