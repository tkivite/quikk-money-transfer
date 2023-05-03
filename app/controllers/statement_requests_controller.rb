# frozen_string_literal: true

class StatementRequestsController < ApplicationController
  # POST /request
  def create
    @statement_request = StatementRequest.new(request_params)
    @statement_request.user = current_user
    if @statement_request.save
      ProcessStatementRequest.call(@statement_request)
      render json: @statement_request, status: :created
    else
      render json: { errors: @statement_request.errors.full_messages },
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
