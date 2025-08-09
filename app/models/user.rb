class User < ApplicationRecord
  enum :role, { student: 0, admin: 1 }

  belongs_to :school, optional: true
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments

  scope :students, -> { where(role: :student) }
  scope :admins, -> { where(role: :admin) }

  def purchased_enrollments
    enrollments.where.not(purchased_at: nil)
  end

  def enrolled_enrollments
    enrollments.where.not(enrolled_at: nil)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
