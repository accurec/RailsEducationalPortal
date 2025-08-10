class User < ApplicationRecord
  enum :role, { student: 0, admin: 1 }

  belongs_to :school, optional: true

  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments

  has_many :course_purchases, dependent: :destroy
  has_many :purchased_courses, through: :course_purchases, source: :course
  
  has_many :term_purchases, dependent: :destroy
  has_many :purchased_terms, through: :term_purchases, source: :term

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
