class PurchasesController < ApplicationController
  def index
    @purchases = Purchase.all
  end

  def update
    @item = Item.find(params[:item_id])
    if @item.update(phase_id: 2)
      render :index
    end
  end

  private
  def item_params
    params.require(:item).permit(phase_id: 2)
  end

end
