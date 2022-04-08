class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @group=Group.new
  end

  def index
    @book=Book.new#本の投稿
    @groups=Group.all
  end

  def show
    @book=Book.new#本の投稿
    @group=Group.find(params[:id])
  end

  def join
    @group=Group.find(params[:group_id])
    @group.users << current_user#@group.usersへcurrent_userを追加
    redirect_to groups_path
  end

  def create
    @group=Group.new(group_params)
    @group.owner_id=current_user.id
    @group.users << current_user#@group.usersへグループ作成者を追加
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

  def destroy
    @group=Group.find(params[:id])
    @group.users.delete(current_user)#current_userを@group.usersから削除
    redirect_to groups_path
  end

  def edit
  end

  private

  def group_params
    params.require(:group).permit(:name,:introduction,:group_image)
  end

  def ensure_correct_user#updateとeditはownerのみ使える
    @group=Group.find(params[:id])
    unless @group.owner_id==current_user.id
      redirect_to groups_path
    end
  end

end
