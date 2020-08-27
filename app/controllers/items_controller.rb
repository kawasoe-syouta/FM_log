class ItemsController < ApplicationController
  before_action :items, only: [:show, :destroy, :edit]
  before_action :move_to_index, except: [:index, :show]

  def index
    @items = Item.all
  end
  
  def show
    
  end

  def destroy
    if @items.destroy
      redirect_to root_path
    else
      alert:"削除ができません"
    end
  end

  def edit

  end

  private
  def items
    @items = Item.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
