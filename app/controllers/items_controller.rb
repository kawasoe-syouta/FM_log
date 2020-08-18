class ItemsController < ApplicationController
<<<<<<< HEAD
  before_action :items, only: [:show, :destroy]
  def index
    @items = Item.all
  end
=======
>>>>>>> 9b1489e... commit
  
  def show
    
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
