class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, only: %i[create destroy]

  def create
    user = User.find_for_database_authentication(email: params[:user][:email])
    if user && user.valid_password?(params[:user][:password])
      sign_in(user)
      redirect_to posts_path
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    sign_out(current_user)
    redirect_to posts_path, notice: 'logged out successfully !!.'
  end
end