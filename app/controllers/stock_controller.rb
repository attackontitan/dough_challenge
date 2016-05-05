class StockController < ApplicationController
  def index
    if params[:search]==""
      @empty_query = true
    elsif params[:search].nil?
      @start = true
    else
      @searched = Stock.search(params[:search])
      unless @searched.nil?
        @count = @searched.size
        @searched = @searched.paginate(:page => params[:page], :per_page => 20)
      end
    end
  end
end
