class ChoicesController < ApplicationController
  before_action :set_organization
  before_action :set_quiz
  before_action :set_question
  before_action :set_choice, only: %i[ show edit update destroy ]
  # GET /choices or /choices.json
  def index
    @choices = @question.choices
  end

  # GET /choices/1 or /choices/1.json
  def show
  end

  # GET /choices/new
  def new
    @choice = @question.choices.new
  end

  # GET /choices/1/edit
  def edit
  end

  # POST /choices or /choices.json
  def create
    @choice = @question.choices.build(choice_params)
    if @choice.save
      redirect_to organization_quiz_question_path(@organization, @quiz, @question), notice: "Choice was successfully created."
    else
      redirect_to organization_quiz_question_path(@organization, @quiz, @question), alert: @choice.errors.full_messages.join(',')
    end
  end

  # PATCH/PUT /choices/1 or /choices/1.json
  def update
    if @choice.update(choice_params)
      redirect_to organization_quiz_question_choices_path(@organization, @quiz, @question), notice: "Choice was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /choices/1 or /choices/1.json
  def destroy
    @choice.destroy
    redirect_to organization_quiz_question_choices_path(@organization, @quiz, @question), notice: "Choice was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def set_quiz
    @quiz = @organization.quizzes.find(params[:quiz_id])
  end

  def set_question
    @question = @quiz.questions.find(params[:question_id])
  end

  def set_choice
    @choice = @question.choices.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def choice_params
    params.require(:choice).permit(:name)
  end
end
