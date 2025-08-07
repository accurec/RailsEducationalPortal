class User < ApplicationRecord
  enum :role, { student: 0, admin: 1 }

  belongs_to :school, optional: true

  scope :students, -> { where(role: :student) }
  scope :admins, -> { where(role: :admin) }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
