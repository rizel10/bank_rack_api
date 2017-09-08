require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'response')
require File.join(File.dirname(__FILE__), '..', 'models', 'account')
require File.join(File.dirname(__FILE__), '..', 'models', 'operation')
require File.join(File.dirname(__FILE__), '..', 'models', 'user')
require File.join(File.dirname(__FILE__), '..', 'policies', 'operation_policy')

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

  # authenticate a user and set's it on @current_user
  def authenticate_user
    @current_user = User.first(cpf: env["HTTP_UID"])
    if @current_user
      unless @current_user.encrypted_auth_token.nil?
        if @current_user.auth_token == env["HTTP_ACCESS_TOKEN"]
          return true
        end
      end
    end
    response.error(103, "Unauthorized")
    return false
  end

  # method used to require parameters in an action
  def require_parameters(param_ary)
    req = []
    param_ary.each do |p|
      req << p unless body.has_key? p
    end

    if req.any?
      response.error(102, "Missing parameter: #{req.join(", ")}")
    end
  end

end