class Public::CustomersController < Public::ApplicationController
  layout 'public/application'
  def show
  end

  def edit
    @customer = Customer.find(current_customer.id)
  end

  def update
    @customer = Customer.find(current_customer.id)
    if @customer.update(customer_params)
      flash[:notice] = "会員情報を更新しました"
      redirect_to customers_path
    else
      render :edit
    end
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def quit
  end

  def withdraw
    #現在ログインしているユーザーを@customerに格納
    @customer = Customer.find(current_customer.id)
     if @customer.update(is_deleted: true)
       flash[:notice] = " 退会しました"
      #sessionIDのresetを行う
      reset_session
      redirect_to root_path
     else
      flash[:notice] = " 退会に失敗しました"
      render :show
     end
  end

  def favorites
    favorites= Favorite.where(customer_id: current_customer.id
    ).pluck(:item_id)
    @favorite_item = Item.find(favorites)
  end

  private

  def customer_params
    params.require(:customer).permit(:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :phone_number, :nick_name)
  end

end
