class Operation < BaseController

  def create
    operation = env["PATH_INFO"].split("/").last
    response.body = JSON[{ response: "Create #{operation} Operation for Account number: #{account_number} with ammount #{body["ammount"]}" }]
    response.status_code = 201
    return response
  end

  def index
    response.body = JSON[{ response: "List Operations of account #{account_number}" }]
    response.status_code = 200
    return response
  end

  private

    def account_number
      return @account_number if @account_number
      return @account_number = env["PATH_INFO"].match(/\d+/).to_s.to_i # Type converted to integer so method is consistent with it's name.
    end


end