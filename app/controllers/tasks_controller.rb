class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sprint
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  after_action :notify_user_on_create, only: :create
  after_action :notify_user_on_update, only: :update

  def index
    @tasks = Task.paginate(page: params[:page], per_page: params[:per_page] || 1)

    respond_to do |format|
      format.html do
        render :index
      end

      format.json do
        render json: {
          data: TaskBlueprint.render(@tasks, view: :detailed),
          pagination: {
            current_page: @tasks.current_page,
            next_page: @tasks.next_page,
            prev_page: @tasks.previous_page,
            total_pages: @tasks.total_pages,
            total_entries: @tasks.total_entries
          }
        }
      end
    end
    authorize Task
  end

  def show
    authorize @task
  end

  def new
    @task = @sprint.tasks.build
    authorize @task
  end

  def create
    @task = @sprint.tasks.build(task_params)
    @task.created_by_id = current_user.id
    authorize @task

    if @task.save
      redirect_to project_sprints_path(@sprint.project_id, @sprint), notice: "Task created successfully."
    else
      render :new
    end
  end

  def edit
    authorize @task
  end

  def update
    authorize @task
    if @task.update(task_params)
      redirect_to [@sprint.project, @sprint, @task], notice: "Task updated successfully."
    else
      render :edit
    end
  end

  def destroy
    authorize @task
    @task.destroy
    redirect_to project_sprint_tasks_path(@sprint.project, @sprint), notice: "Task deleted successfully."
  end

  private

  def set_sprint
    @sprint = Sprint.find(params[:sprint_id])
  end

  def set_task
    @task = @sprint.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :task_type, :sprint_id, :start_date, :end_date, :due_date, :points, :status, :priority, :assignee_id)
  end

  def notify_user_on_create
    return unless @task.assignee

    NotificationJob.perform_later(@task.assignee, "You have been assigned a new task #{@task.id}.")
  end

  def notify_user_on_update
    if @task.assignee
      NotificationJob.perform_later(@task.assignee, "Your task has been modified.")
    end
    return unless @task.created_by
    NotificationJob.perform_later(@task.created_by, "Your task has been modified.")
  end

end
