class Stock < ActiveRecord::Base
  validates_uniqueness_of :symbol


  def self.search(search)
    unless search.blank?
      where("name LIKE ?", "%#{search}%") + where("symbol LIKE ?", "%#{search}%")
      # else
      #   Stock.all
    end
  end

  def draw

  end

  def get_data
    yahoo_client ||= YahooFinance::Client.new
    yahoo_client.historical_quotes(self.symbol, {raw: false, start_date: Time::now-(24*60*60*30), end_date: Time::now}) # 30 days worth of data
  end

  def format_data
    data_hash = Hash.new
    data_open_struct = self.get_data
    data_open_struct.each do |single_day|
      single_day.trade_date.slice!(0..4)
      data_hash[single_day.trade_date] = 0.25*(single_day.open.to_f+single_day.close.to_f+single_day.high.to_f+single_day.low.to_f)
    end
    data_hash
  end
end
