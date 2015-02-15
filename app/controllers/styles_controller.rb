class StylesController < ApplicationController

  before_action :set_style, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_signed_in, except: [:index, :show]

  def index
    @styles = Style.all
  end

  def show
  end

  def new
    @style = Style.new
  end

  def create
    @style = Style.create params.require(:style).permit(:style, :description)

    if @style.save
      redirect_to @style
    else
      render :new
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
end