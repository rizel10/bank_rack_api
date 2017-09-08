class Response
  attr_accessor :status_code, :headers, :body

  def initialize(hdrs={})
    @headers = hdrs
  end

  def rack_response
    [status_code, headers, Array(body)]
  end
  
  def error(code, msg="")
    @error = true
  	case code
  	when 101
      self.status_code = 422
      self.body = JSON[{ errors: msg, code: code, system_message: "Validation error" }]
  	when 102
      self.status_code = 400
      self.body = JSON[{ errors: msg, code: code, system_message: "Missing parameters" }]
    when 103
      self.status_code = 401
      self.body = JSON[{ errors: msg, code: code, system_message: "Invalid credentials" }]
    when 104
      self.status_code = 403
      self.body = JSON[{ errors: msg, code: code, system_message: "Forbbiden" }]
  	end	
  end

  def error?
    @error    
  end

end