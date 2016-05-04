class StockController < ApplicationController
  def index
    @searched = Stock.search(params[:search]).paginate(:page => params[:page], :per_page => 20)
  end
end
