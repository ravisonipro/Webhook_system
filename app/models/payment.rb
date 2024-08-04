class Payment < ApplicationRecord
  validates :amount, :note, presence: true
end
