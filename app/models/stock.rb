class Stock < ActiveRecord::Base
  validates_uniqueness_of :symbol

  def search

  end
end
