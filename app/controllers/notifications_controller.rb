# frozen_string_literal: true

class NotificationsController < ApplicationController
    #  Fetch user notifications
  def index
    @my_notifications = Notification.my_notifications(current_user)
    render json: @my_notifications, status: 200
  end
end
