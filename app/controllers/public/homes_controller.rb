class Public::HomesController < ApplicationController
  layout 'public/application'
  def top
    # 販売中のitemのみ取得
    @item = Item.where(is_active:true )
    @newitems = @item.order(created_at: :desc).limit(3)
  end

  def about
  end
end
