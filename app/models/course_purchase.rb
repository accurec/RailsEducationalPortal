class CoursePurchase < ApplicationRecord
  belongs_to :user
  belongs_to :course

  enum :payment_method, { credit_card: 0, license_code: 1, other: 2 }

  validates :payment_method, presence: true
  validates :purchased_at, presence: true
end
