class Brewery < ActiveRecord::Base
  include RatingAverage

  validates :year, numericality: {greater_than_or_equal_to: 1042, less_than_or_equal_to: Proc.new {Date.today.year}}
  validates :name, presence: true

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }

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

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating||0) }
    sorted_by_rating_in_desc_order[0,n]
  end
  private

end
