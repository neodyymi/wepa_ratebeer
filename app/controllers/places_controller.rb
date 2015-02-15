class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def show
    @place = BeermappingApi.find_pub(params[:id])
    if(@place.nil?)
      redirect_to places_path, notice: "No such pub: #{params[:id]}"
    end

  end
end