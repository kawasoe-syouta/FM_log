class ItemsController < ApplicationController
  before_action :items, only: [:show, :destroy]
  def index
    @items = Item.all
  end
  
  def show
    
  end

  def destroy
    @items.destroy
  end

  private
  def items
    @items = Item.find(params[:id])
  end
end
