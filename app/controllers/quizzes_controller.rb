class QuizzesController < ApplicationController
  before_action :set_organization
  before_action :set_quiz, only: %i[ show edit update destroy ]
  before_action :set_tags, only: %i[edit new]
  # GET /quizzes or /quizzes.json
  def index
    @quizzes = @organization.quizzes
  end

  # GET /quizzes/1 or /quizzes/1.json
  def show
  end

  # GET /quizzes/new
  def new
    @quiz = @organization.quizzes.build
    @tag = @quiz.tags.build
  end

  # GET /quizzes/1/edit
  def edit
  end

  # POST /quizzes
  def create
    @quiz = @organization.quizzes.build(quiz_params)

    if @quiz.save
      redirect_to organization_quiz_url(@organization, @quiz), notice: "Quiz was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /quizzes/1
  def update
    if @quiz.update(quiz_params)
      redirect_to organization_quiz_url(@organization, @quiz), notice: "Quiz was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /quizzes/1
  def destroy
    @quiz.destroy

    redirect_to organization_quizzes_url, notice: "Quiz was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_quiz
    @quiz = @organization.quizzes.find(params[:id])
  end

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def set_tags
    @tags = Tag.all
  end

  # Only allow a list of trusted parameters through.
  def quiz_params
    params.require(:quiz).permit(:topic, :description, :organization_id, tags_attributes: [:id, :level], tag_ids: [])
  end
end
