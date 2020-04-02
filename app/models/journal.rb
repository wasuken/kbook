class Journal < ApplicationRecord
  has_many :incomes
  has_many :expenes
  belongs_to :user
end
