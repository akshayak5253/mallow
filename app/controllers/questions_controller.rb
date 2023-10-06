class QuestionsController < ApplicationController
  before_action :set_organization_quiz
  before_action :set_question, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # GET /questions
  def index
    @pagy, @questions = pagy(@quiz.questions.all)
  end

  # GET /questions/1
  def show
    @question = Question.find(params[:id])
    if user_signed_in? && !@question.marked_as_read?(current_user)
      @question.mark_as_read(current_user)
    end
  end

  # GET /questions/new
  def new
    @question = @quiz.questions.build

  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  def create
    @question = @quiz.questions.build(question_params)
    @question.user=current_user
    if @question.save
      redirect_to organization_quiz_question_path(@organization, @quiz, @question), notice: "Question was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end
  def mark_as_read
    @question = Product.find(params[:id])
    current_user.read_products << @question
    head :ok
  end

  def update
    authorize! :update, @question
    if @question.update(question_params)
      redirect_to organization_quiz_question_url(@organization, @quiz, @question), notice: "Question was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
    authorize! :destroy, @question
    redirect_to organization_quiz_questions_url(@organization, @quiz), notice: "Question was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = @quiz.questions.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def question_params
    params.require(:question).permit(:brief, :user_id)
  end

  def set_organization_quiz
    @organization = Organization.find(params[:organization_id])
    @quiz = @organization.quizzes.find(params[:quiz_id])
  end

end
