class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password
  validates :password, :format => {:with => /(?=.*[A-Z])./, message: "Password needs atleast one capital letter"}, length: {minimum: 6}
  validates :username, uniqueness: true, length: {minimum: 3, maximum: 15}

  has_many :ratings
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    styles = ratings.map { |r| r.style}.uniq
    best = styles.first
    best_average = 0
    styles.each do |s|
      currents = ratings.find_all {|r| r.style == s}.each.map { |ra| ra.score}
      current = currents.each.inject() { |sum, n| sum+n }
      current = current / currents.count
     if (current > best_average)
        best = s
        best_average = current
      end
    end
    best

  end
end
