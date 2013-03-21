class InfosController < ApplicationController
  def index
    render json: Study.find(params[:study_id]).infos
  end

  def show
    render json: Info.find(params[:id])
  end

  def search
  end
end
