class Brewery < ActiveRecord::Base
  include RatingAverage

  validates :year, numericality: {greater_than_or_equal_to: 1042,
                                  less_than_or_equal_to: 2015}
  validates :name, presence: true

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def print_report
    puts name
    puts "established at year #{year}"
    beers puts "number of beers #{beers.count}"
  end
  def restart
    self.year = 2015
    puts "changed year to #{self.year}"
  end
end
