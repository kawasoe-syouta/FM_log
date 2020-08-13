class SellsController < ApplicationController
  def index
  end

  def edit
    @sell = Sell.find[:id]
  end
end