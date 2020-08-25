class ItemsController < ApplicationController
  before_action :items, only: [:show, :destroy]

  def index
    @items = Item.all
    @parents = Category.where(ancestry: nil)
  end

  def show
    @item = Item.find(params[:id])
    @parents = Category.where(ancestry: nil)
  end

  def destroy
    if @items.destroy
      redirect_to root_path
    else
      alert:"削除ができません"
    end
  end

  private
  def items
    @items = Item.find(params[:id])
  end

end
