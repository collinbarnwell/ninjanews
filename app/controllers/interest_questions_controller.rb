class InterestQuestionsController < ApplicationController
  def new
    unless current_user && current_user.is_admin
      redirect_to signin_path
      return
    end
    @interest_question = InterestQuestion.new
  end

  def create
    return unless current_user.is_admin
    @interest_question = InterestQuestion.new(interest_question_params)
    if @interest_question.save
      redirect_to :back, notice: 'Interest question created.'
    else
      render action: 'new'
    end
  end

  def edit
    unless current_user && current_user.is_admin
      redirect_to signin_path
      return
    end
    @interest_question = InterestQuestion.find(params[:id])
  end

  def update
    return unless current_user.is_admin
    @interest_question = InterestQuestion.find(params[:id])
    if interest_question.update_attributes(interest_question_params)
      redirect_to :back, notice: 'Interest question updated.'
    else
      render action: 'edit'
    end
  end

  def index
    unless current_user && current_user.is_admin
      redirect_to signin_path
      return
    end
    @interest_questions = InterestQuestion.all
  end

  def destroy
    return unless current_user.is_admin
    InterestQuestion.find(params[:id]).destroy
    redirect_to interest_questions_path, notice: 'Interest question destroyed.'
  end

  private

    def interest_question_params
      params.require(:interest_question).permit(:question_text)
    end
end
