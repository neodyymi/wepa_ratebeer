class BeersController < ApplicationController
  before_action :set_beer, only: [:show, :edit, :update, :destroy]
  before_action :set_styles_and_breweries, only: [:edit, :new, :create]
  before_action :ensure_that_signed_in, except: [:index, :show, :list, :nglist]
  before_action :is_admin, only: [:destroy]
  before_action :skip_if_cached, only:[:index]

  def set_styles_and_breweries
    @styles = Style.all
    @breweries = Brewery.all
  end

  def skip_if_cached
    @order = params[:order] || 'name'
    return render :index if fragment_exist?( "beerlist-#{@order}"  )
  end
  # GET /beers
  # GET /beers.json

  def nglist

  end

  def list

  end

  def index
    @beers = Beer.includes(:brewery, :style).all

    @beers = case @order
               when 'name' then @beers.sort_by{ |b| b.name }
               when 'brewery' then @beers.sort_by{ |b| b.brewery.name }
               when 'style' then @beers.sort_by{ |b| b.style.style }
             end
  end

  # GET /beers/1
  # GET /beers/1.json
  def show
    @rating = Rating.new
    @rating.beer = @beer
  end

  # GET /beers/new
  def new
    @beer = Beer.new
  end

  # GET /beers/1/edit
  def edit
  end

  # POST /beers
  # POST /beers.json
  def create
    expire_all
    @beer = Beer.new(beer_params)

    respond_to do |format|
      if @beer.save
        format.html { redirect_to beers_path, notice: 'Beer was successfully created.' }
        format.json { render :show, status: :created, location: @beer }
      else
        format.html { render :new }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /beers/1
  # PATCH/PUT /beers/1.json
  def update
    expire_all
    respond_to do |format|
      if @beer.update(beer_params)
        format.html { redirect_to @beer, notice: 'Beer was successfully updated.' }
        format.json { render :show, status: :ok, location: @beer }
      else
        format.html { render :edit }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beers/1
  # DELETE /beers/1.json
  def destroy
    expire_all
    @beer.destroy
    respond_to do |format|
      format.html { redirect_to beers_url, notice: 'Beer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_beer
    @beer = Beer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def beer_params
    params.require(:beer).permit(:name, :style_id, :brewery_id)
  end


  def expire_all
    ["beerlist-name", "beerlist-brewery", "beerlist-style"].each{ |f| expire_fragment(f) }
  end
end
