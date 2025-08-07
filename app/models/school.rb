class School < ApplicationRecord
  has_many :terms, dependent: :destroy
  has_many :students, class_name: 'User', dependent: :nullify
end
