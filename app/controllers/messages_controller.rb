class MessagesController < ApplicationController
  before_action :reject_non_related,only: [:show]#相互フォローか確認

  def show
    @user=User.find(params[:id])
    rooms=current_user.entrys.pluck(:room_id)#pluckは特定のカラムの値を配列で取り出す
    entrys=Entry.find_by(user_id:@user.id,room_id:rooms)

    unless entrys.nil?
      @room=entrys.room
    else
      @room=Room.new
      @room.save
      Entry.create(user_id:current_user.id, room_id:@room.id)#自分の部屋側
      Entry.create(user_id:@user.id,room_id:@room.id)#相手側の部屋側（ルームは一緒でユーザーが違う）
    end

    @messages=@room.messages
    @message=Message.new(room_id:@room.id)
  end

  def create
    @message=current_user.messages.new(message_params)#ログインしてる（自分）側の新規メッセージ
    render :validater unless @message.save
  end

  private

  def message_params
    params.require(:message).permit(:content, :room_id)
  end

  def reject_non_related#相互フォローか確認
    user=User.find(params[:id])
    unless current_user.following?(user)&&user.following?(current_user)
      redirect_to books_path
    end
  end

end
