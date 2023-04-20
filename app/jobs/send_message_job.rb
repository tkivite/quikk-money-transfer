# frozen_string_literal: true

# app/jobs/send_message_job.rb

class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(notification)
    p '============================================'
    p 'Sending message and update status'
    p notification.message
    p notification.recipient
    notification.status = 1
    notification.save
    p 'Message sent and status updated'
    p '============================================'
  end
end
