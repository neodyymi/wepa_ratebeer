class StylesController < ApplicationController

  before_action :set_style, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_signed_in, except: [:index, :show]
  before_action :is_admin, only: [:destroy]

  def index
    @styles = Style.all
  end

  def show
  end

  def new
    @style = Style.new
  end

  def create
    @style = Style.new(style_params)
    respond_to do |format|
      if @style.save
        format.html { redirect_to @style, notice: 'Style was successfully created.' }
        format.json { render :show, status: :created, location: @style }
      else
        format.html { render :new }
        format.json { render json: @style.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @style.update(style_params)
        format.html { redirect_to @style, notice: 'Style was successfully updated.' }
        format.json { render :show, status: :ok, location: @style }
      else
        format.html { render :edit }
        format.json { render json: @style.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    style = Style.find(params[:id])
    style.destroy if current_user
    redirect_to styles_path
  end
  def set_style
    @style = Style.find(params[:id])
  end

  def style_params
    params.require(:style).permit(:style, :description)
  end
end