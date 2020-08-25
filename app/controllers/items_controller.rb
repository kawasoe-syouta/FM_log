class ItemsController < ApplicationController
  

  def index
    @items = Item.all
    @parents = Category.where(ancestry: nil)
  end

  def show
    @item = Item.find(params[:id])
    @parents = Category.where(ancestry: nil)
  end

end
