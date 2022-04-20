class BooksController < ApplicationController
  before_action :authenticate_user!
  impressionist :actions=>[:show]


  def show
    @book = Book.find(params[:id])
    @book_new=Book.new
    @user=User.find(@book.user.id)
    @book_comment=BookComment.new
    impressionist(@book)
  end

  def index
    #from  = Time.current.at_beginning_of_day１週間いいね順で並ぶ時の書き方
    #to = (from + 6.day).at_end_of_day
    #@books=Book.includes(:favorited_users).sort{|a,b|b.favorited_users.includes(:favorites).where(created_at: from...to).size<=>a.favorited_users.includes(:favorites).where(created_at: from...to).size}
    @book = Book.new
    if params[:latest]
      @books = Book.latest
    elsif params[:star_count]
      @books = Book.star_count
    else
     @books = Book.all
    end
    @book_tag=@book.tags
  end


  def create
    @book = Book.new(book_params)
    @book.user_id=current_user.id
    tag_list=params[:book][:name].split(",")
    if @book.save
      @book.save_tag(tag_list)
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
    params.require(:book).permit(:title, :body, :rate)
  end

  def ensure_correct_user
    @book=Book.find(params[:id])
    unless @book.user==current_user
      redirect_to books_path
    end
  end
end
