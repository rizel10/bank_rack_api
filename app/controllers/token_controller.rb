class TokenController < BaseController

  def create
    req_param = []
    req_param << "cpf" unless body.has_key? "cpf"
    req_param << "pin" unless body.has_key? "pin"

    if req_param.any?
      response.body = JSON[{ errors: "Missing parameter: #{req_param.join(", ")}", code: 102 }]
      response.status_code = 400
      return response
    end

    @user = User.first(cpf: body["cpf"])
    
    unless @user
      response.body = JSON[{ errors: "invalid pin or cpf", code: 103 }]
      response.status_code = 422
      return response
    end

    if @user.pin == body["pin"]
      token = SecureRandom.urlsafe_base64(nil, false)
      @user.update(auth_token: token)
      response.body = @user.to_hash.merge(auth_token: token).to_json
      response.status_code = 200
      return response
    else
      response.body = JSON[{ errors: "invalid pin or cpf", code: 103 }]
      response.status_code = 422
      return response
    end
  end

  def destroy
    
  end

end