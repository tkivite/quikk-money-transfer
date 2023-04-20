# frozen_string_literal: true

class RequestsController < ApplicationController
  # POST /request
  def create
    @request = Request.new(request_params)
    @request.user = current_user
    if @request.save
      ProcessStatementRequest.call(@request)
      render json: @request, status: :created
    else
      render json: { errors: @request.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def request_params
    params.permit(
      :start_date, :end_date, :request_type
    )
  end
end
