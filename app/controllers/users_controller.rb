class UsersController < ApplicationController
  def show
    unless @user = current_user
      redirect_to signin_path
      return
    end
    update_feed_scores!(@user)
    update_article_scores!(@user)
    @articles = get_user_articles.all
  end

  def index
    unless current_user && current_user.is_admin
      redirect_to signin_path
      return
    end
    @users = User.all
  end

  def edit
    unless @user = current_user
      redirect_to signin_path
      return
    end
    @interest_questions = InterestQuestion.all
    InterestQuestion.all.each do |iq|
      @user.interest_answers.find_or_initialize_by(interest_question_id: iq.id)
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      update_feed_scores!(@user)
      redirect_to @user, notice: 'User updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    return unless current_user && current_user.is_admin
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'User destroyed.'
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                   :zipcode, :interest_answers, 
                                   interest_answers_attributes: [:user_id, :interest_rating, 
                                   :interest_question_id])
    end

    def update_feed_scores!(user) # override ALL feed scores
      Feed.find_each(batch_size: 100) do |feed|
        total_rating = 0
        rating_count = 0
        RelationLevel.where(feed_id: feed.id).each do |r|
          total_rating += InterestAnswer.where(interest_question_id: r.interest_question, 
                                                 user_id: user.id).first.interest_rating * r.score
          rating_count += 1
        end

        fs = FeedScore.where(feed: feed, user: user).first_or_initialize
        fs.score = total_rating.to_f / rating_count.to_f
        fs.save!
      end
    end

    def update_article_scores!(user) # override ALL article scores
      Article.find_each(batch_size: 100) do |article|
        article_score = ArticleScore.where(user_id: user, article_id: article).first_or_initialize
        feed_score = FeedScore.find_by(user: user, feed: article.feed).score
        total_tags = article.tags.count.to_f
        matched_tags = article.tags.inject(0) do |sum, t|
          sum += 1 if user.tags.include? t
          sum
        end.to_f
        article_score.score = feed_score * matched_tags
        article_score.save!
      end
    end
    # data mining approach - find similarity between tags and subjects

    def get_user_articles
      user = current_user
      Article.joins(:article_scores).where(article_scores: { user_id: user.id }).order('score DESC')
    end
  end
