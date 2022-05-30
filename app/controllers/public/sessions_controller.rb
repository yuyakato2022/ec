# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController

  layout 'public/application'
  # before_action :configure_sign_in_params, only: [:create]
  before_action :customer_state, only: [:create]

protected

# 退会しているかを判断するメソッド
def customer_state
    ## 【処理内容1】 入力されたemailからアカウントを1件取得
    @customer = Customer.find_by(email: params[:customer][:email])
    ## アカウントを取得できなかった場合、このメソッドを終了する
    ## もし@customerがある（!true=false）なら下の処理へ、ない（!false=true）ならreturnして
    return if !@customer
    ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致（true）　かつ　is_withdrawalが（false）
    if @customer.valid_password?(params[:customer][:password]) && !(@customer.is_deleted?)
    ## 【処理内容3】（!false=true）だった場合、退会していないのでcreateを実行
    else
    ## !true（false）だった場合、退会しているのでサインアップ画面に遷移する
    flash[:notice] = "退会済みです。新規会員登録を行なってください"
    redirect_to new_customer_registration_path
    end
end



  private

  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインしました"
    root_path
  end


  def after_sign_out_path_for(resource)
    flash[:notice] = " ログアウトしました"
    root_path
  end



  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end



  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end



end
