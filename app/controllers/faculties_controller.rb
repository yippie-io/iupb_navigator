class FacultiesController < ApplicationController
  def index
    render json: Faculty.all
  end

  def show
    render json: Faculty.find(params[:id])
  end
end
