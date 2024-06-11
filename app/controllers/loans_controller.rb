class LoansController < ApplicationController
  before_action :set_loan, only: %i[show edit update destroy]

  def index
    @loans = Loan.where(user_id: current_user.id)
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
    @loan.status = 'Borrowed'
    @loan.owner_id = @book.user_id
    @loan.borrower_id = current_user.id
    if @loan.save
      redirect_to @loan
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
