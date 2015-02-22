class Rating < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user

  scope :recent, ->(num) { order('created_at DESC').limit(num)}

  validates :score, numericality: { greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 50,
                                    only_integer: true}

  def to_s
    return "#{beer.name} #{score}"
  end

  def style
    beer.style
  end
end
