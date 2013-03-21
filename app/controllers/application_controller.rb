class ApplicationController < ActionController::API
  before_filter :set_cache_header
  
  protected
  def default_serializer_options
    {root: false}
  end
  
  # caches content for 1 hour via varnish. 
  # use in as method or as a filter
  def set_cache_header(duration=21600) 
    response.headers['Cache-Control'] = "public, max-age=#{duration.to_s}"
  end
  
end
