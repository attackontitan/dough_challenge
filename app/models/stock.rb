class Stock < ActiveRecord::Base
  validates_uniqueness_of :symbol

  def self.search(search)
    unless search.blank?
      where("name LIKE ?", "%#{search}%") + where("symbol LIKE ?", "%#{search}%")
    # else
    #   Stock.all
    end
  end

end
