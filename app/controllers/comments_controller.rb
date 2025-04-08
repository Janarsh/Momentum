class CommentsController < ApplicationController
  before_action :set_task
  before_action :set_comment, only: [ :destroy ]
  before_action :authorize_comment, only: [ :destroy ]

  def create
    @comment = @task.comments.build(comment_params)
    @comment.posted_by = current_user

    if @comment.save
      flash[:notice] = "Comment added successfully."
      redirect_to project_sprint_task_path(@task.sprint.project, @task.sprint, @task)
    else
      flash[:alert] = "Failed to add comment."
      Rails.logger.info @comment.errors.inspect
      redirect_to project_sprint_task_path(@task.sprint.project, @task.sprint, @task)
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = "Comment deleted successfully."
    redirect_to project_sprint_task_path(@task.sprint.project, @task.sprint, @task)
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_comment
    @comment = @task.comments.find(params[:id])
  end

  def authorize_comment
    authorize @comment
  end

  def comment_params
    params.require(:comment).permit(:message)
  end
end
