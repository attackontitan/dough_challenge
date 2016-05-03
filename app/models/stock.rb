class Stock < ActiveRecord::Base
  validates_uniqueness_of :symbol

  def create

  end
end
