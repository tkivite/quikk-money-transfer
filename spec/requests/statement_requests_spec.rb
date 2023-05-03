require 'rails_helper'

RSpec.describe StatementRequestsController, type: :request do
  let(:user) { create(:user) }
  let(:valid_params) do
    {
      start_date: Date.today,
      end_date: Date.today,
      request_type: 0
    }
  end
  let(:valid_headers) do
    { Authorization: "Bearer #{authenticate(user)}" }
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new statement request' do
        expect do
          post statement_requests_url,
               params: valid_params, headers: valid_headers, as: :json
        end.to change(StatementRequest, :count).by(1)
      end

      it 'renders a JSON response with the new statement request' do
        post statement_requests_url,
             params: valid_params, headers: valid_headers
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end
end
