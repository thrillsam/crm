class AuthenticationController < ApplicationController
  skip_before_action :authenticate_user

  def login
    @user = User.find_by(email: login_params[:email])
    if @user&.authenticate(login_params[:password])
      token = jwt_encode(user_id: @user.id)
      render json: {token: token}, status: :ok
    else
      render json: {error: 'unauthorized'}, status: :unauthorized
    end
  end

  def logout
  end

  private
    def login_params
      params.require(:login).permit(:email, :password)
    end
end
