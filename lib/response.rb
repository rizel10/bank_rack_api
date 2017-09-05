class Response
  attr_accessor :status_code, :headers, :body

  def initialize(hdrs={})
    @headers = hdrs
  end

  def rack_response
    [status_code, headers, Array(body)]
  end
  
end