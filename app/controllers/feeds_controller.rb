class FeedsController < ApplicationController
  def new
    if current_user.is_admin
      @feed = Feed.new
      @sources = Source.all
      @interest_questions = InterestQuestion.all
    end
  end

  def create
    if current_user.is_admin
      @feed = Feed.new(feed_params)
      if @feed.save
        redirect_to '/feeds', notice: 'Feed created.'
      else
        render action: 'new'
      end
    end
  end

  def edit
    if current_user.is_admin
      @feed = Feed.find(params[:id])
      @sources = Source.all
      @interest_questions = InterestQuestion.all
    end
  end

  def update
    if current_user.is_admin
      @feed = Feed.find(params[:id])
      if @feed.update_attibutes(feed_params)
        redirect_to :back, notice: 'Feed updated.'
      else
        render action: 'new'
      end
    end
  end

  def destroy
    if current_user.is_admin
      Feed.find(params[:id]).destroy
      redirect_to feeds_path, notice: 'Feed destroyed.'
    end
  end

  def index
    if current_user.is_admin
      @feeds = Feed.all
    end
  end

  private

    def feed_params
      params.require(:feed).permit(:url, :source_id, :section, :area_importance, :is_local_news)
    end
end
