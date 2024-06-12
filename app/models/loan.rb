class Loan < ApplicationRecord
  belongs_to :book

  def self.check_overdue
    overdue_loans = where('end_date < ?', Date.today)
    overdue_loans.each do |loan|
      # Implement your logic to handle overdue books, e.g., sending notifications
      loan.update(status: 'overdue')
    end
  end

  def block_user
    user.update(blocked: true)
  end

end
