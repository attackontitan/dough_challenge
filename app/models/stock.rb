class Stock < ActiveRecord::Base
  validates_uniqueness_of :symbol


  def self.search(search)
    unless search.blank?
      where("name LIKE ?", "%#{search}%") + where("symbol LIKE ?", "%#{search}%")
      # else
      #   Stock.all
    end
  end

  def format_data
    data_arr = Array.new
    # data_arr << ['Date','Price']
    begin
      data_open_struct = get_data
      puts "hehe"
    rescue
      puts "nonononon"
      return false
    end
    data_open_struct.each do |single_day|
      # single_day.trade_date.slice!(0..4)
      data_arr << [single_day.trade_date, 0.25*(single_day.open.to_f+single_day.close.to_f+single_day.high.to_f+single_day.low.to_f)]
    end
    data_arr
  end

  private

  def get_data
    yahoo_client ||= YahooFinance::Client.new
    yahoo_client.historical_quotes(self.symbol, {raw: false, start_date: Time::now-(24*60*60*30), end_date: Time::now}) # 30 days worth of data
  end

end
