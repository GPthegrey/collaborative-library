class LoansController < ApplicationController
  before_action :set_loan, only: %i[show edit update destroy]

  def index
    @loans = Loan.where(borrower_id: current_user.id)
  end

  def show
  end

  def new
    @loan = Loan.new
  end

  def create
    @book = Book.find(params[:book_id])
    @loan = Loan.new(book_id: @book.id)
    @loan.start_date = Date.today
    @loan.end_date = Date.today + 30.days
    @loan.status = 'Active'
    @loan.owner_id = @book.user_id
    @loan.borrower_id = current_user.id
    if @loan.save
      @book.update(status: 'Borrowed')
      redirect_to profile_path
    else
      render 'new'
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

  private


  def set_loan
    @loan = Loan.find(params[:loan_id])
  end
end
