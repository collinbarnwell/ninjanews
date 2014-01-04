class SubscriptionsController < ApplicationController
  def create
    @tag = Tag.find_by(title: params[:commit])
    Subscription.create(tag_id: @tag.id, user_id: current_user.id)
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end

  def destroy
    Subscription.find(params[:id]).destroy
    @tag = Tag.find(params[:id])
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end
end