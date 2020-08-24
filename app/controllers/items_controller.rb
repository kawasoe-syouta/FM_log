class ItemsController < ApplicationController
  before_action :set_parents, only: [:new, :create, :edit]

  def search
    respond_to do |format|
      format.html
      format.json do
        if params[:parent_id]
          @childrens = Category.find(params[:parent_id]).children
        elsif params[:children_id]
          @grandChilds = Category.find(params[:children_id]).children
        end
      end
    end
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
  end

  def index
    @items = Item.all
    @item = Item.new()
    @item_images = @item.item_images.build
    @parents = Category.where(ancestry: nil)
  end

  def show
    @parents = Category.where(ancestry: nil)
  end

end
