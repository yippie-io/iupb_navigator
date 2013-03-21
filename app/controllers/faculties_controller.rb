class FacultiesController < ApplicationController
  def index
    render json: Faculty.order(:name)
  end

  def show
    render json: Faculty.find(params[:id])
  end
end
