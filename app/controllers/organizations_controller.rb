class OrganizationsController < ApplicationController
  before_action :set_organization, only: %i[ show edit update destroy ]

  # GET /organizations or /organizations.json
  def index
    @organizations = Organization.all
  end

  # GET /organizations/1 or /organizations/1.json
  def show
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  def create
    @organization = Organization.new(organization_params)
    @organization.created_user = current_user

    if @organization.save
      redirect_to organization_url(@organization), notice: "Organization was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /organizations/1
  def update
    if @organization.update(organization_params)
      redirect_to organization_url(@organization), notice: "Organization was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /organizations/1 or
  def destroy
    @organization.destroy

    redirect_to organizations_url, notice: "Organization was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_organization
    @organization = Organization.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def organization_params
    params.require(:organization).permit(:name, :icon)
  end
end
