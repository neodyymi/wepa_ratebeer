module RatingAverage
  def average_rating
    sum = self.ratings.average(:score)
    sum.to_f
  end
end