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
    yahoo_client.historical_quotes(self.symbol, {start_date: Time::now-(24*60*60*30), end_date: Time::now}) # 30 days worth of data
  end


end
