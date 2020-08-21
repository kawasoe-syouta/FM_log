class ItemsController < ApplicationController
  

  def index
    @categories = Category.order(:id)
  end

  def show
    @categories = Category.order(:id)
  end

  
end
