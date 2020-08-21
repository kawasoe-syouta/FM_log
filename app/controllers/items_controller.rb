class ItemsController < ApplicationController
  

  def index
    @items = Item.all
    @categories = Category.order(:id)
  end

  def show
    @categories = Category.order(:id)
  end

end
