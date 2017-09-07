class OperationController < BaseController

  def create
    operation = env["PATH_INFO"].split("/").last
    response.body = JSON[{ response: "Create #{operation} Operation for Account number: #{account_number} with ammount #{body["ammount"]}" }]
    response.status_code = 201
    return response
  end

  def index
    set_user
    response.body = Operation.where(user_id: @user.id).filter(filter_params).all.to_json
    response.status_code = 200
    return response
  end

  private

    def account_number
      return @account_number if @account_number
      return @account_number = env["PATH_INFO"].match(/\d+/).to_s.to_i # Type converted to integer so method is consistent with it's name.
    end

    def filter_params
      uri = Addressable::URI.new 
      uri.query = env["QUERY_STRING"]
      uri.query_values
    end

    def set_account
      @account = Account.first(account_number: account_number)      
    end

    def set_user
      @user = User.first(id: env["PATH_INFO"].match(/\d+/).to_s)      
    end

end