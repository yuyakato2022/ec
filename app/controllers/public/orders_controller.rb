class Public::OrdersController < ApplicationController
  layout 'public/application'

  def index
    @orders = current_customer.orders.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @orders = @order.order_details
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
      @cart_items = current_customer.cart_items
      @cart_items.each do |cart_item|
        @order_detail = OrderDetail.create(order_id: @order.id,
                                           item_id: cart_item.item_id,
                                           quantity: cart_item.quantity,
                                           price: cart_item.item.price
                                           )
      end
      @cart_items.destroy_all
      redirect_to orders_complete_path
    else
      render "confirm"
    end
  end

  def confirm
    @order = Order.new(order_params)

    if params[:order][:select_address] == "0"
      @order.postcode = current_customer.postcode
      @order.address = current_customer.address
      @order.address_name = current_customer.full_name
    elsif params[:order][:select_address] == "1"
      unless current_customer.deliveries.exists? #配送先登録がない場合
        flash.now[:notice] = "登録済みの住所がありません"
        render "new"
      else
        @delivery = Delivery.find(params[:order][:delivery_id])
        @order.postcode = @delivery.postcode
        @order.address = @delivery.address
        @order.address_name = @delivery.address_name
      end
    elsif params[:order][:select_address] == "2"
      if ( params[:order][:postcode] || params[:order][:address] || params[:order][:address_name] ).empty?
        flash.now[:notice] = "住所を正しく入力してください"
        render "new"
      else
        delivery_new = current_customer.deliveries.new(delivery_params)
        delivery_new.save
        @order.postcode = params[:order][:postcode]
        @order.address = params[:order][:address]
        @order.address_name = params[:order][:address_name]
      end
    else
      flash.now[:notice] = "住所を選択してください"
      render "new"
    end

    @cart_items = current_customer.cart_items
    @postage = 800
    @items_price = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @total_pay = @postage + @items_price

  end

  def complete
  end

  private

    def order_params
      params.require(:order).permit(
        :pay_way,
        :postcode,
        :address,
        :address_name,
        :postage,
        :total_pay
        )
    end
    def delivery_params
      params.require(:order).permit(:postcode, :address, :address_name)
    end
end
