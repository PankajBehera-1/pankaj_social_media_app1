class Users::RegistrationsController < Devise::RegistrationsController
  private
    def sign_up_params
      params.require(:user).permit(:username, :date_of_birth, :gender, :email, :phone, :country, :password, :password_confirmation, :avatar)
      
    end
end