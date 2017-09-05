 require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'response')

class BaseController
  attr_reader :env
  attr_reader :response

  def initialize env
    @env = env
    @response = Response.new({ "content-type" => "application/json" })
  end
end