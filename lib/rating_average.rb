module RatingAverage
  def average_rating
    return 0 if self.ratings.empty?
    self.ratings.average(:score).to_f
  end
end