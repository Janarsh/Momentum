class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [ :show, :update, :destroy ]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  after_action :notify_user_on_update, only: :update

  def index
    @projects = policy_scope(Project)
  end

  def show
    authorize @project
  end

  def new
    @project = Project.new
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    @project.created_by = current_user

    authorize @project
    if @project.save
      redirect_to @project, notice: "Project created successfully."
    else
      logger.debug "Project errors: #{@project.errors.full_messages}"  # Debugging
      render :new, status: 422
    end
  end

  def edit
    @project = Project.find(params[:id])
    authorize @project
  end

  def update
    authorize @project
    if @project.update(project_params)
      redirect_to @project, notice: "Project updated successfully."
    else
      render :edit
    end
  end

  def destroy
    authorize @project
    @project.destroy
    redirect_to projects_path, notice: "Project deleted successfully."
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def notify_user_on_update
    return unless @project.created_by
    NotificationJob.perform_later(@project.created_by, "Your project has been modified.")
  end
end
