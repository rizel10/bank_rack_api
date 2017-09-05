 require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'response')

class BaseController
  attr_reader :env
  attr_reader :body
  attr_reader :response

  def initialize env
    @env = env
    @response = Response.new({ "content-type" => "application/json" }) # Adds content-type header for any controllers, since for now I'll only work with JSON
    
    body_tmp = Rack::Request.new(env).body.read
    @body = body_tmp == "" ? {} : JSON[body_tmp] # provides body content to controllers, also parses them to JSON, since for now I'll only be working with JSON
  end
end