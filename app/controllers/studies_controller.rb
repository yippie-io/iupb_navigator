class StudiesController < ApplicationController
  def index
    render json: Faculty.find(params[:faculty_id]).studies.order(:name)
  end

  def show
    render json: Study.find(params[:id])
  end

  def search
  end
end
