class Style < ActiveRecord::Base
  include RatingAverage
  has_many :beers
  has_many :ratings, through: :beers

  def to_s
    self.style
  end
  def add_style(s)
    if Style.find_by style:s
      Style.find_by style:s
    else
      Style.create(style:s)
    end
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Style.all.sort_by { |s| -(s.average_rating||0)}
    sorted_by_rating_in_desc_order[0,n]
  end
end
