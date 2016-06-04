class PasswordResetsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset
      redirect_to root_url, :notice => "Se envió un email a la dirección indicada con las instrucciones para restaurar la contraseña."
    else
      redirect_to root_url, :notice => "Este correo no está registrado en el sistema."
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    @user.update_attributes(params.require(:user).permit(:password, :password_confirmation))

    if @user.password_reset_sent_at < 5.minutes.ago
      redirect_to new_password_reset_path, :alert => "El token de reseteo ha caducado."
      # http://stackoverflow.com/questions/17568062/activemodelforbiddenattributeserror-in-passwordresetscontrollerupdate
    elsif @user.update_attributes(params.require(:user).permit(:password, :password_confirmation))
      redirect_to root_url, :notice => "La contraseña ha sido actualizada."
    else
      render :edit
    end
  end

  def new
  end

  def user_params
    # Necesario para resetear la contraseña!
    # params.require(:user).permit(:name, :login, :email, :password, :password_confirmation, :id,
    # :password_salt, :crypted_password,:current_password)
    # params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password,
    # :password_reset_token)


  end
end
