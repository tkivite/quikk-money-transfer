# frozen_string_literal: true

class ProcessStatementRequest < ApplicationService
  attr_reader :request

  def initialize(request)
    @request = request
  end

  def call
    p '====================EMAIL============================== '
    p "Should sent email to #{@request.user.email} "
    p '=====================EMAIL============================= '
  end
end
