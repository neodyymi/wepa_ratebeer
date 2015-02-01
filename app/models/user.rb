class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password
  validates :password, :format => {:with => /(?=.*[A-Z])./, message: "Password needs atleast one capital letter"}, length: {minimum: 6}
  validates :username, uniqueness: true, length: {minimum: 3, maximum: 15}

  has_many :ratings
  has_many :beers, through: :ratings
end
