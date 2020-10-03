class Api::V1::UsersController < ApplicationController
  before_action :authorized, only: [:auto_login,
                                    :show]

  # SHOW USER BY ID api/v1/users/<id>
  def show
    user = User.find(params[:id])
    render json: {user: user}
  end

  # INDEX ALL USERS GET api/v1/users
  def index
    users = User.all
    render json: {users: users}
  end

  # DELETE USER DELETE api/v1/users/<id>
  def destroy
    User.find(params[:id]).destroy
    head 204
  end

  # UPDATE USER PUT api/v1/users/<id>
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user, status: :ok
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  #POST api/v1/users
  def create
    user = User.new(user_params)
    if user.save
      token = encode_token({user_id: user.id, permisos: "admin"})
      render json: {user: user, token: token}, status: :created
    else
      render json: {error: "Invalid username or password"}
    end
  end

  #POST api/v1/users/login
  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = encode_token({user_id: user.id})
      render json: {user: user, token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end

  #Method just to try JWT
  def auto_login
    render json: {"hola": "norman"} #@user
  end

  private

  def user_params
    params.permit(:email, :password)
  end

end
