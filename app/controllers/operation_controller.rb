class Operation < BaseController

  def create
    response.body = JSON[{ response: "Create Operation Withdraw/Deposit" }]
    response.status_code = 201
    return response
  end

  def index
    response.body = JSON[{ response: "List Operations" }]
    response.status_code = 200
    return response
  end

end