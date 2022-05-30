class Admin::ItemsController < ApplicationController
  layout 'admin/application'
  protect_from_forgery

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "新規商品　登録完了"
      redirect_to admin_item_path(@item.id)
    else
      render "new"
    end
  end


  def show
    @item = Item.find(params[:id])
  end


  def index
    @items = Item.all.page(params[:page]).per(6)
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "商品編集完了"
      redirect_to admin_items_path
    else
      render "edit"
    end
  end




  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :image, :price, :description, :is_active)
  end

end
