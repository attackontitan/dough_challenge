class StockController < ApplicationController

  def index
    if params[:search]==""
      @empty_query = true
    elsif params[:search].nil?
      @start = true
    else
      @query_str = params[:search].gsub(/\W+/, '')
      @searched = Stock.search(@query_str)
      unless @searched.nil?
        @count = @searched.uniq{|x| x.symbol}.size
        @searched = (@searched.uniq{|x| x.symbol} .sort_by &:name).paginate(:page => params[:page], :per_page => 20)
      end
    end
  end

  def draw
    @stock = Stock.find_by_id params[:id]
    @draw_data = @stock.format_data
    # @test_data = @draw_data.to_s
  end

end
