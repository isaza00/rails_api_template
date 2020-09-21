class Api::V1::UsersController < ApplicationController
  before_action :authorized, only: [:auto_login,
                                    :show,
                                    :index,
                                    :destroy]

  # SHOW USER BY ID /users/<id>
  def show
    user = User.find(params[:id])
    render json: {user: user}
  end

  # INDEX ALL USERS
  def index
    users = User.all
    render json: {users: users}
  end

  # DELETE USER
  def destroy
    User.find(params[:id]).destroy
    head 204
  end

  # UPDATE USER
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user, status: :ok
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  # REGISTER
  def create
    user = User.new(user_params)
    if user.save
      token = encode_token({user_id: user.id})
      render json: {user: user, token: token}, status: :created
    else
      render json: {error: "Invalid username or password"}
    end
  end

  # LOGGING IN
  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = encode_token({user_id: user.id})
      render json: {user: user, token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end

  def auto_login
    render json: {"hola": "norman"} #@user
  end

  private

  def user_params
    params.permit(:email, :password)
  end

end
