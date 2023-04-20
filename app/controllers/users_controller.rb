# frozen_string_literal: true

class UsersController < ApplicationController
  # before_action :authorize_request, except: :create
  skip_before_action :authenticate_request
  before_action :find_user, except: %i[create index]

  # GET /users
  def index
    @users = User.all
    render json: @users.to_json(include: :account), except: [:password_digest], status: :ok
  end

  # GET /users/{username}
  def show
    render json: @user.includes(:account), status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      account = create_account(@user)
      render json: { user: @user, account: account }, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/{id}
  def update
    return if @user.update(user_params)

    render json: { errors: @user.errors.full_messages },
           status: :unprocessable_entity
  end

  # DELETE /users/{id}
  def destroy
    @user.destroy
  end

  private

  def find_user
    @user = User.find_by_id!(params[:_id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(
      :surname, :othernames, :email, :mobile, :password, :password_confirmation
    )
  end

  def create_account(user)
    Account.create(
      account_number: @user.surname,
      user_id: user.id,
      currency: 'KES',
      balance: 0.00,
      status: 1
    )
  end
end
