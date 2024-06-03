class LoansController < ApplicationController
  before_action :set_loan, only: %i[show edit update delete]

  def index
    @loans = Loan.all
  end

  def show
  end

  def new
    @loan = Loan.new
  end

  def create
    @loan = Loan.new(loan_params)
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

  def delete
    @loan.destroy
    redirect_to loans_path
  end

  private

  def loan_params
    params.require(:loan).permit(:book_id, :user_id, :loan_date, :return_date)
  end
end
