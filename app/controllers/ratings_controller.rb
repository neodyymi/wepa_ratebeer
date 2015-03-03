class RatingsController < ApplicationController
  def index
    Rails.cache.write("time", Time.new()-601) if Rails.cache.read("time").nil?

    if(Time.new() - Rails.cache.read("time") > 300)
      Rails.cache.write("time", Time.new())
      Rails.cache.write("ratings count", Rating.all.count)
      Rails.cache.write("recent 5", Rating.recent(5))
      Rails.cache.write("brewery top 3", Brewery.top(3))
      Rails.cache.write("beer top 3", Beer.top(3))
      Rails.cache.write("user top 3", User.top(3))
      Rails.cache.write("styles top 3", Style.top(3))
    end


    @ratingscount = Rails.cache.read "ratings count"


    @recent = Rails.cache.read "recent 5"

    @top_breweries = Rails.cache.read "brewery top 3"

    @top_beers = Rails.cache.read "beer top 3"

    @top_users = Rails.cache.read "user top 3"

    @top_styles = Rails.cache.read "styles top 3"
    end

    def new
      @rating = Rating.new
      @beers = Beer.all
    end

    def create
      @rating = Rating.create params.require(:rating).permit(:score, :beer_id)

      if @rating.save
        current_user.ratings << @rating
        redirect_to current_user
      else
        @beers = Beer.all
        render :new
      end

    end

    def destroy
      rating = Rating.find params[:id]
      rating.delete if current_user == rating.user
      redirect_to :back
    end


    end