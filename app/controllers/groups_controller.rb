class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @book=Book.new#本の投稿
    @groups=Group.all
  end

  def show
    @book=Book.new#本の投稿
    @group=Group.find(params[:id])
  end

  def create
    @group=Group.new(group_params)
    @group.owner_id=current_user.id
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
      render :edit
    end
  end

  def edit
  end

  def new
    @group=Group.new
  end

  private

  def group_params
    params.require(:group).permit(:name,:introduction,:image)
  end

  def ensure_correct_user#updateとeditはownerのみ使える
    @group=Group.find(params[:id])
    unless @group.owner_id==current_user.id
      redirect_to groups_path
    end
  end

end
