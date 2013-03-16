class ApplicationController < ActionController::API
  
  protected
  def default_serializer_options
    {root: false}
  end
end
