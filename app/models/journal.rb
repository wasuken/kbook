class Journal < ApplicationRecord
  has_many :incomes
  has_many :expenes
  has_many :users
end
