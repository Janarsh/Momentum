class NotificationJob < ApplicationJob
  queue_as :notifications

  def perform(user, message)
    Rails.logger.info "Notification sent to #{user.email}. Message: #{message}"
  end
end
