require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe "GET /users" do
    let!(:user) { create(:user) }
    let(:user_json) { user.to_json }
    before do
      get "/users"
    end

    it "returns a success response" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /users" do
    let(:valid_params) do
      {
        surname: "Doe",
        othernames: "John",
        email: "john@example.com",
        mobile: "0712345678",
        password: "password",
        password_confirmation: "password"
      }
    end

    context "with valid params" do
      before do
        post "/users", params: valid_params
      end

      it "creates a new user" do
        expect(User.count).to eq(1)
      end

      it "returns a success response" do
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      let(:invalid_params) { valid_params.merge(email: "") }

      before do
        post "/users", params: invalid_params
      end

      it "does not create a new user" do
        expect(User.count).to eq(0)
      end

      it "returns an error response" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT /users/:id" do
    let!(:user) { create(:user) }
    let(:new_surname) { "Smith" }
    let(:valid_params) { { surname: new_surname } }

    context "with valid params" do
      before do
        put "/users/#{user.id}", params: valid_params
      end

      it "updates the user" do
        expect(user.reload.surname).to eq(new_surname)
      end

      it "returns a success response" do
        expect(response).to have_http_status(:success)
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { email: "" } }

      before do
        put "/users/#{user.id}", params: invalid_params
      end

      it "does not update the user" do
        expect(user.reload.email).to_not eq("")
      end

      it "returns an error response" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /users/:id" do
    let!(:user) { create(:user) }

    before do
      delete "/users/#{user.id}"
    end

    it "deletes the user" do
      expect(response.status).to eq 204
    end

    it "returns a success response" do
      expect(response).to have_http_status(:success)
    end
  end
end
