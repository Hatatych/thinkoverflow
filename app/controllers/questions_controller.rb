class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:update, :show, :edit]

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.new
  end

  def edit; end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.author = current_user
    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    flash[:error] = 'Error while deleting' unless current_user && current_user.questions.find_by(id: params[:id])&.destroy
    redirect_to questions_path
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
