class LoansController < ApplicationController
  before_action :set_loan, only: %i[show edit update destroy]

  def index
    @loans = Loan.where(borrower_id: current_user.id).where(status: 'Active')
    @requested_loans = Loan.where(borrower_id: current_user.id).where(status: 'Pending')
    @loans_pending = Loan.where(owner_id: current_user.id).where(status: 'Pending')
    @books_leant = Loan.where(owner_id: current_user.id).where.not(status: 'Pending')
    @overdue_loans_borrower = Loan.where(borrower_id: current_user.id).where(status: 'overdue')
    @overdue_loans_owner = Loan.where(owner_id: current_user.id).where(status: 'overdue')
  end

  def show
  end

  def new
    @loan = Loan.new
  end

  def create
    @book = Book.find(params[:book_id])
    if @book.status == 'Available'
      @loan = Loan.new(book_id: @book.id)
      @loan.start_date = Date.today
      @loan.end_date = Date.today + 30.days
      @loan.status = 'Pending'
      @loan.owner_id = @book.user_id
      @loan.borrower_id = current_user.id
      if @loan.save
        redirect_to profile_path
      else
        render 'new'
      end
    else
      redirect_to books_path, notice: 'El libro no está disponible para préstamo.'
    end
  end

  def accept_loan
    @loan = Loan.find(params[:loan_id])
    @loan.update(status: 'Accepted')
    @loan.book.update(status: 'Unavailable')
    redirect_to loans_path
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

  private


  def set_loan
    @loan = Loan.find(params[:loan_id])
  end
end
