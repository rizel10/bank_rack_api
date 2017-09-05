class Operation < BaseController

  def create
    Response.new.tap do |response|
      response.body = "Create Operation Withdraw/Deposit"
      response.status_code = 201
    end
  end

  def index
    Response.new.tap do |response|
      response.body = "List Operations"
      response.status_code = 200
    end
  end

end