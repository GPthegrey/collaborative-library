class Loan < ApplicationRecord
  belongs_to :book
  belongs_to :user_offerer
  belongs_to :user_receiver
end
