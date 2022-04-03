class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model=params[:model]
    @word=params[:word]
    @method=params[:method]
    if @model=="User"
      @users=User.looks(@method,@word)
    else
      @books=Book.looks(@method,@word)
    end
  end

end
