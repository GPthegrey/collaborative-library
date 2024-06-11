class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]

  def index
    @books = Book.all
    @loan = Loan.new
  end

  def show
    @loan = Loan.new
  end

  def my_books
    @books = Book.where(user_id: current_user.id)
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    @book.rating = 0
    @book.status = 'Available'
    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    if @book.status == 'Available'
      @book.destroy
      redirect_to books_path, status: :see_other
    else
      redirect_to @book, notice: 'No puede eliminar un libro que no está disponible.'
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :description, :genre, :language)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
