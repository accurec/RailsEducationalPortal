class CoursePurchase < ApplicationRecord
  belongs_to :user
  belongs_to :course

  enum :payment_method, { credit_card: 0, license_code: 1, other: 2 }
end
