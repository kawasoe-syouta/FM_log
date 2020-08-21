class ItemsController < ApplicationController
  before_action :items, only: [:show, :destroy]
  def index
    @items = Item.all
  end
  

  def index
    @categories = Category.order(:id)
  end

  def show
    @categories = Category.order(:id)
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
