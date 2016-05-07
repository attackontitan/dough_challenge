class StockController < ApplicationController

  def index
    if params[:search]==""
      @empty_query = true
    elsif params[:search].nil?
      @start = true
    else
      @searched = Stock.search(params[:search]).uniq{|x| x.symbol}
      @query_str = params[:search]
      unless @searched.nil?
        @count = @searched.size
        @searched = (@searched.sort_by &:name).paginate(:page => params[:page], :per_page => 20)
      end
    end
  end

  def draw
    @stock = Stock.find params[:id]
    @draw_data = @stock.format_data
    # @draw_data = [["02-10",1],["02-11",3],["02-12",5],["02-13",8],["02-14",4],["02-15",2]]
    @test_data = @draw_data.to_s
    # @chart = new Chartkick.LineChart("chart-1", @draw_data);
  end

end
