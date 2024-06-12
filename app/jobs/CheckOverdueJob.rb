class CheckOverdueJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info "CheckOverdueJob started at #{Time.current}"
    Loan.check_overdue
    Rails.logger.info "CheckOverdueJob finished at #{Time.current}"
  end
end
