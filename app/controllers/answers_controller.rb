class AnswersController < ApplicationController
  before_action :find_question, only: [:index, :new, :create]
  before_action :find_answer, only: [:update]

  def index
    @answers = @question.answers
  end

  def new
    @answer = @question.answers.new
  end

  def edit
    @answer = Answer.find(params[:id])
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.author = current_user
    if @answer.save
      redirect_to @question
    else
      flash[:alert] = 'Error saving answer!'
      render 'questions/show'
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to @answer.question
    else
      render :edit
    end
  end

  def destroy
    @answer = current_user.answers.find_by(id: params[:id])&.destroy
    redirect_to @answer.question
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
