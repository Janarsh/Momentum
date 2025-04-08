class AttachmentsController < ApplicationController
  before_action :set_task
  before_action :set_attachment, only: [ :destroy ]
  before_action :authorize_attachment, only: [ :destroy ]

  def create
    @attachment = @task.attachments.build(attachment_params)

    if @attachment.save
      flash[:notice] = "Attachment uploaded successfully."
      redirect_to project_sprint_task_path(@task.sprint.project, @task.sprint, @task)
    else
      flash[:alert] = "Failed to upload attachment."
      redirect_to project_sprint_task_path(@task.sprint.project, @task.sprint, @task)
    end
  end

  def destroy
    @attachment.destroy
    flash[:notice] = "Attachment deleted successfully."
    redirect_to project_sprint_task_path(@task.sprint.project, @task.sprint, @task)
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_attachment
    @attachment = @task.attachments.find(params[:id])
  end

  def authorize_attachment
    authorize @attachment
  end

  def attachment_params
    params.require(:attachment).permit(:file_name)
  end
end
