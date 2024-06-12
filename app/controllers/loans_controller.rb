class LoansController < ApplicationController
  before_action :set_loan, only: %i[edit update destroy]

  def index
    @loans = Loan.where(borrower_id: current_user.id).where(status: 'Accepted')
    @requested_loans = Loan.where(borrower_id: current_user.id).where(status: 'Pending')
    @loans_pending = Loan.where(owner_id: current_user.id).where(status: 'Pending')
    @books_leant = Loan.where(owner_id: current_user.id).where(status: 'Accepted')
    @overdue_loans_borrower = Loan.where(borrower_id: current_user.id).where(status: 'overdue')
    @overdue_loans_owner = Loan.where(owner_id: current_user.id).where(status: 'overdue')
  end

  def show
    @loan = Loan.find(params[:id])
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
    @loan = Loan.find(params[:id])
    @loan.update(status: 'Accepted')
    @loan.update(start_date: Date.today)
    @loan.update(end_date: Date.today + 30.days)
    @loan.book.update(status: 'Unavailable')
    redirect_to loans_path
  end

  def reject_loan
    @loan = Loan.find(params[:id])
    @loan.update(status: 'Rejected')
    redirect_to loans_path
  end

  def return_loan
    @loan = Loan.find(params[:id])
    @loan.update(status: 'Finalized')
    @loan.book.update(status: 'Available')
    redirect_to loans_path
  end

  def time_extension_request
    @loan = Loan.find(params[:id])
  end

  def time_extension_accept
    @loan = Loan.find(params[:id])

  end

  def time_extension_reject
    @loan = Loan.find(params[:id])
  end

  private

  def set_loan
    @loan = Loan.find(params[:loan_id])
  end
end
