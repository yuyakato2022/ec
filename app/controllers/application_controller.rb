class ApplicationController < ActionController::Base
  # URLにadminが含まれるページはadminにログインしないと見れないよ
  before_action :authenticate_admin!, if: :admin_url

  def admin_url
    request.fullpath.include?("/admin")
  end

  # deviseの初期設定ではメールアドレスしか保存されないので、他の項目を増やす為の記述
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters

    if resource_class == Customer
      devise_parameter_sanitizer.permit(:sign_up, keys: [ :email, :last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :phone_number, :password, :password_confirmation, :nick_name ])
      devise_parameter_sanitizer.permit(:sign_in,keys:[:email])
      devise_parameter_sanitizer.permit(:account_update,keys:[ :email, :last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :phone_number, :nick_name])
    else
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email])
      devise_parameter_sanitizer.permit(:sign_in,keys:[:email])
      devise_parameter_sanitizer.permit(:account_update,keys:[:name,:email])
    end
  end


end
