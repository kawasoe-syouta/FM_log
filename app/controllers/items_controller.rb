class ItemsController < ApplicationController
  before_action :items, only: [:show, :destroy]

  def index
    @items = Item.all
    @parents = Category.where(ancestry: nil)
  end

  def show
    @item = Item.find(params[:id])
    
    @category = Category.find_by(id: @item.category_id) 
    if @category.ancestry == nil
      @parent = @category
      @child = nil
      @grandchild = nil
    elsif @category.ancestry.include?("/") == false
      @parent = Category.find_by(id: @category.ancestry)
      @child = @category
      @grandchild = nil
    else
      @parent = Category.find_by(id: @category.ancestry.split("/")[0])
      @child = Category.find_by(id: @category.ancestry.split("/")[1])
      @grandchild = @category
    end
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
