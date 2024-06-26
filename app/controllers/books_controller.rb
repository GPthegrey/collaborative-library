class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  def index

    @loan = Loan.new

    @search_performed = params[:query].present? || params[:location].present? || params[:genre].present?

    @books = Book.all

    @markers = @books.geocoded.map do |book|
      {
        lat: book.latitude,
        lng: book.longitude,
        info_window_html: render_to_string(partial: "books/info_window", locals: {book: book}),
        marker_html: render_to_string(partial: "marker", locals: {book: book})

      }
    end

    if params[:query].present?
      @books = @books.search_by_title_and_author(params[:query])
    end

    if params[:location].present?
      @books = @books.near(params[:location], 20)
    end

    if params[:genre].present?
      @books = @books.by_genre(params[:genre])
    end

    if params[:language].present?
      @books = @books.by_language(params[:language])
    end

    @books = @books.order(:author) # Sorting alphabetically by author

  end

  def show
    @loan = Loan.new
  end

  def book_search
    if params[:query].present?
      service = GoogleBooksService.new(ENV['GOOGLE_BOOKS_API_KEY'])
      @books = service.search_books(params[:query])['items']
    end

    respond_to do |format|
      format.html
      format.json { render json: @books }
    end
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
    @book.address = current_user.address
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
