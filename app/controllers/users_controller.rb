class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @articles = get_user_articles.limit(50)
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @interest_questions = InterestQuestion.all
  end

  def edit
    @user = User.find(params[:id])
    @interest_questions = InterestQuestion.all
  end

  def create
    @user = User.new(params[:user])
    @user.name.downcase!
    @user.email.downcase!
    score_all_feeds(@user)
    if @user.save
      sign_in_ @user
      redirect_to @user, notice: 'Welcome!'
    else
      render action: 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user, notice: 'User updated.'
      score_all_feeds(@user)
    else
      render action: 'edit' 
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :zipcode)
      params.require(:interest_answer).permit!
    end

    def score_all_feeds(user)
      Feed.find_each(batch_size: 100) do |feed|
        unless feed_score = FeedScore.find_by(feed_id: feed.id, user_id: user.id)
          feed_score = FeedScore.new(feed: feed, user: user)
        end

        total_rating = 0
        rating_count = 0
        RelationLevel.where('feed_id=?', feed.id).each do |r|
          total_rating += InterestAnswer.find_by(interest_question: r.interest_answer.interest_question, 
                                                 user_id: user.id).interest_rating * r.score
          rating_count += 1
        end

        feed_score.score = total_rating.to_f / rating_count.to_f
      end
    end

    def get_user_articles
      user = current_user
      Article.joins("LEFT JOIN 'feed_scores' ON feed_scores.feed_id=articles.feed_id")
             .where('feed_scores.user_id=(?)', user.id)
             .where('articles.created_at > ?', 2.days.ago)
             .order('score DESC')
    end
end
