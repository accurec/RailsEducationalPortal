class Term < ApplicationRecord
  belongs_to :school

  has_many :courses, dependent: :destroy
  
  has_many :term_purchases, dependent: :destroy
  has_many :purchasers, through: :term_purchases, source: :user
end
