class BooksController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @new_book = Book.new
    @books = Book.all
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
    unless current_user == @book.user
      redirect_to books_path
    end
  end

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      flash[:notice] = "You have created the book successfully."
      redirect_to book_path(@new_book.id)
    else
      @books = Book.all
      @user = User.find(current_user.id)
      render :index
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated the book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end

  end

  def destroy
    book = Book.find(params[:id])
    unless current_user == book.user
      redirect_to books_path
    end
    book.destroy
    redirect_to books_path
  end

private
    def book_params
      params.require(:book).permit(:title, :body)
    end
end