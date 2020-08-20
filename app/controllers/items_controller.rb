class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy]
  def index
    items = Item.all
  end
  
  def show
  end

  def destroy
    item.destroy
  end
  
  private
  def set_item
    @items = Item.find(params[:id])
  end
end
