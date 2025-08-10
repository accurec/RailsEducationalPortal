class TermPurchase < ApplicationRecord
  belongs_to :user
  belongs_to :term

  enum :payment_method, { credit_card: 0, license_code: 1 }

  validates :payment_method, presence: true
  validates :purchased_at, presence: true
end
