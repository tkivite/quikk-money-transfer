require 'rails_helper'

RSpec.describe TransactionsController, type: :request do
  describe "GET /transactions" do
    let!(:user) { create(:user) }

    before do
      log_in(user)
      get_request("/transactions", json_body["access_token"])
    end

    it "returns a success response" do      
      expect(response).to have_http_status(:success)
    end

    it "returns a list of transactions" do
      expect(json_body).to be_an(Array)
    end
  end

  describe "POST /transactions" do
    let!(:user) { create(:user) }
    let!(:user2) { create(:user) }
    let(:valid_params) do
      {
        amount: 100,
        date_of_transaction:  Time.zone.now,
        sender_id: user.account.id,
        recipient_id: user2.account.id,
        transaction_type: 'fundstransfer', 
        reference:  Faker::Alphanumeric.alphanumeric(number: 10) 
      }
    end

    context "with valid params" do
      before do
        log_in(user)
        post_request("/transactions", json_body["access_token"], valid_params)
      end

      it "creates a new transaction" do
        expect(Transaction.count).to eq(1)
      end

      it "returns insufficient balance " do
        expect(json_body['status_description']).to eq("insufficient balance")
      end

      it "returns a success response" do
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      let(:invalid_params) { valid_params.merge(amount: "") }

      before do
        log_in(user)
        post_request("/transactions", json_body["access_token"], invalid_params)
      end

      it "does not create a new user" do
        expect(Transaction.count).to eq(0)
      end

      it "returns an error response" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

end
