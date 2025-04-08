class SprintsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_sprint, only: [:show, :update, :edit, :destroy]

  after_action :notify_user_on_update, only: :update

  def index
    @sprints = Sprint.includes(:project).all
  end

  def create
    @sprint = @project.sprints.build(sprint_params)
    @sprint.created_by_id = current_user.id
    authorize @sprint
    if @sprint.save
      redirect_to project_path(@project), notice: "Sprint created successfully."
    else
      Rails.logger.info "Sprint errors: #{@sprint.errors.full_messages}"
      render json: @sprint.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @sprint
    if @sprint.update(sprint_params)
      redirect_to @project, notice: "Sprint updated successfully."
    else
      Rails.logger.info "Sprint errors: #{@sprint.errors.full_messages}"
      render json: @sprint.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @sprint
    @sprint.destroy
    redirect_to @project, notice: "Sprint deleted successfully."
  end

  def show
    authorize @sprint
  end

  def new
    @sprint = @project.sprints.build
    authorize @sprint
  end

  def edit
    authorize @sprint
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_sprint
    @sprint = Sprint.find(params[:id])
  end

  def sprint_params
    params.require(:sprint).permit(:name, :description, :project_id, :start_date, :end_date)
  end

  def notify_user_on_update
    return unless @sprint.created_by
    NotificationJob.perform_later(@sprint.created_by, "Your sprint has been modified.")
  end
end
