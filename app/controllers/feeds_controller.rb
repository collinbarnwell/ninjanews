class FeedsController < ApplicationController
  def new
    unless current_user && current_user.is_admin
      redirect_to signin_path
      return
    end
    @feed = Feed.new
    @sources = Source.all
    @interest_questions = InterestQuestion.all
    InterestQuestion.all.each do |iq|
      @feed.relation_levels.find_or_initialize_by(interest_question_id: iq.id)
    end
  end

  def create
    return unless current_user.is_admin
    @feed = Feed.new(feed_params)
    if @feed.save
      redirect_to '/feeds', notice: 'Feed created.'
    else
      render action: 'new'
    end
  end

  def edit
    unless current_user && current_user.is_admin
      redirect_to signin_path
      return
    end
    @feed = Feed.find(params[:id])
    @sources = Source.all
    @interest_questions = InterestQuestion.all
    InterestQuestion.all.each do |iq|
      @feed.relation_levels.find_or_initialize_by(interest_question_id: iq.id)
    end
  end

  def update
    return unless current_user.is_admin
    @interest_questions = InterestQuestion.all
    @feed = Feed.find(params[:id])
    if @feed.update_attributes(feed_params)
      redirect_to :back, notice: 'Feed updated.'
    else
      render action: 'new'
    end
  end

  def destroy
    return unless current_user.is_admin
    Feed.find(params[:id]).destroy
    redirect_to feeds_path, notice: 'Feed destroyed.'
  end

  def index
    unless current_user && current_user.is_admin
      redirect_to signin_path
      return
    end
    @feeds = Feed.all
  end

  private

    def feed_params
      params.require(:feed).permit(:url, :source_id, :section, 
                                   :area_importance, :is_local_news, 
                                   relation_levels_attributes: 
                                   [:interest_question_id, :score, :feed_id])
    end
end
