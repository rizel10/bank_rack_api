class TokenController < BaseController

  def create
    require_parameters(["cpf", "pin"])
      return response
    end

    @user = User.first(cpf: body["cpf"])
    
    unless @user
      response.error(103, "invalid pin or cpf")
      return response
    end

    if @user.pin == body["pin"]
      token = @user.sign_in
      response.headers['access-token'] = token
      response.headers['uid'] = @user.cpf
      response.body = @user.serialize
      response.status_code = 200
      return response
    else
      response.error(103, "invalid pin or cpf")
      return response
    end
  end

  def destroy
    if authenticate_user
      @current_user.sign_out
      response.headers = {}
      response.body = JSON[{}]
      response.status_code = 204
    end
    return response
  end

end