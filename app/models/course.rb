class Course < ApplicationRecord
  belongs_to :term

  has_many :enrollments, dependent: :destroy
  has_many :users, through: :enrollments
  
  has_many :course_purchases, dependent: :destroy
  has_many :purchasers, through: :course_purchases, source: :user
end
