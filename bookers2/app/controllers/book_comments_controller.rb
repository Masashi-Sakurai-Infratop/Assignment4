class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    book_comment = current_user.book_comments.new(book_comment_params)
    book_comment.book_id = book.id
    book_comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    book_comment = BookComment.find(params[:id])
    unless current_user == book_comment.user
      redirect_back(fallback_location: root_path)
    else
      book_comment.destroy
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
