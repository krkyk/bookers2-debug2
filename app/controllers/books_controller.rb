class BooksController < ApplicationController
  before_action :authenticate_user!


  def show
    @book = Book.find(params[:id])
    @book_new=Book.new
    @user=User.find(@book.user.id)
    @book_comment=BookComment.new
    unless ViewCount.find_by(user_id: current_user.id, book_id: @book.id)
      current_user.view_counts.create(book_id: @book.id)
    end
  end

  def index
    #@books = Book.all
    from  = Time.current.at_beginning_of_day
    to = (from + 6.day).at_end_of_day
    @books=Book.includes(:favorited_users).sort{|a,b|b.favorited_users.includes(:favorites).where(created_at: from...to).size<=>a.favorited_users.includes(:favorites).where(created_at: from...to).size}
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book=Book.find(params[:id])
    unless @book.user==current_user
      redirect_to books_path
    end
  end
end
