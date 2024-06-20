class LoansController < ApplicationController
  before_action :set_loan, only: %i[show edit update destroy accept_loan reject_loan return_loan extension_request extension_accept extension_reject]

  def index
    @loans = Loan.where(borrower_id: current_user.id).where(status: 'Accepted')
    @requested_loans = Loan.where(borrower_id: current_user.id).where(status: 'Pending')
    @loans_pending = Loan.where(owner_id: current_user.id).where(status: 'Pending')
    @completed_loans_borrower = Loan.where(borrower_id: current_user.id).where(status: 'Completed')

    @books_leant = Loan.where(owner_id: current_user.id).where(status: 'Accepted')
    @overdue_loans_owner = Loan.where(owner_id: current_user.id).where(status: 'overdue')
    @overdue_loans_borrower = Loan.where(borrower_id: current_user.id).where(status: 'overdue')
    @completed_loans = Loan.where(owner_id: current_user.id).where(status: 'Completed')

    @review = Review.new


  end

  def show
    @review = Review.new
    @rev_review = @loan.reviews.where(user_reviewer: current_user)

  end

  def new
    @loan = Loan.new
  end

  def create
    @book = Book.find(params[:book_id])
    if @book.status == 'Available'
      @loan = Loan.new(book_id: @book.id)
      @loan.status = 'Pending'
      @loan.owner_id = @book.user_id
      @loan.borrower_id = current_user.id
      if @loan.save
        redirect_to loans_path
      else
        render 'new'
      end
    else
      redirect_to books_path, notice: 'El libro no está disponible para préstamo.'
    end
  end

  def edit
  end

  def update
    if @loan.update(loan_params)
      redirect_to @loan
    else
      render 'edit'
    end
  end

  def destroy
    @loan.destroy
    redirect_to loans_path
  end

  def accept_loan
    @loan.update(status: 'Accepted')
    @loan.update(start_date: Date.today)
    @loan.update(end_date: Date.today + 30.days)
    @loan.book.update(status: 'Unavailable')
    redirect_to loans_path
  end

  def reject_loan
    @loan.update(status: 'Rejected')
    redirect_to loans_path
  end

  def return_loan
    @loan.update(status: 'Finalized')
    @loan.book.update(status: 'Available')
    redirect_to loans_path
  end

  def extension_request
    @loan.update(extension: 'Extension Requested')
  end

  def extension_accept
    @loan.update(extension: 'Extension Accepted')
    @loan.update(end_date: @loan.end_date + 15.days)
    redirect_to loans_path
  end

  def extension_reject
    @loan.update(extension: 'Extension Rejected')
  end

  private

  def set_loan
    @loan = Loan.find(params[:id])
  end
end
