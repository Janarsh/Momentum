class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_projects = Project.where(created_by: current_user)
    @my_sprints = Sprint.where(project_id: @my_projects.pluck(:id))
    @my_tasks = Task.where(assignee_id: current_user.id)
  end
end
