class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    JWT.encode(payload, 's3cr3t')
  end

  def token
    if request.headers['Authorization']
      auth_header = request.headers['Authorization']
      auth_header = auth_header.split(' ')[1]
    else
      return nil
    end
    begin
      JWT.decode(auth_header, 's3cr3t', true, algorithm: 'HS256')
    rescue JWT::DecodeError
      return nil
    end
  end

  def logged_in?
    if token
      puts token
      @user = User.find_by_id(token[0]['user_id'])
      return @user
    end
    return false
  end

  def authorized
    render json: { message: 'Please log in' },
           status: :unauthorized unless logged_in?
  end

end
