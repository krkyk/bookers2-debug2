class RelationshipsController < ApplicationController
  
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  
  def destroy
  end
  
  def followings
  end
  
  def followers
  end
  
end
