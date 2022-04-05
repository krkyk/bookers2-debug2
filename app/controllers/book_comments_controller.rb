class BookCommentsController < ApplicationController

  def create
    @book=Book.find(params[:book_id])
    @book_comment=BookComment.new(book_comment_params)
    @book_comment.user_id=current_user.id
    @book_comment.book_id=@book.id
    #binding.pry
    @book_comment.save
    @comment=BookComment.new

  end

  def destroy
    @book=Book.find(params[:book_id])
    BookComment.find(params[:id]).destroy
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
