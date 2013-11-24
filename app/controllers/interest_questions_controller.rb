class InterestQuestionsController < ApplicationController
  def new
    if current_user.is_admin
      @interest_question = InterestQuestion.new
    end
  end

  def create
    if current_user.is_admin
      @interest_question = InterestQuestion.new(interest_question_params)
      if @interest_question.save
        redirect_to :back, notice: 'Interest question created.'
      else
        render action: 'new'
      end
    end
  end

  def edit
    if current_user.is_admin
      @interest_question = InterestQuestion.find(params[:id])
    end
  end

  def update
    if current_user.is_admin
      @interest_question = InterestQuestion.find(params[:id])
      if interest_question.update_attributes(interest_question_params)
        redirect_to :back, notice: 'Interest question updated.'
      else
        render action: 'edit'
      end
    end
  end

  def index
    if current_user.is_admin
      @interest_questions = InterestQuestion.all
    end
  end

  def destroy
    if current_user.is_admin
      InterestQuestion.find(params[:id]).destroy
      redirect_to interest_questions_path, notice: 'Interest question destroyed.'
    end
  end

  private

    def interest_question_params
      params.require(:interest_question).permit(:question_text)
    end
end
