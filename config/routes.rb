BankRackApplication.router.config do
  post "/accounts/:account_number/operations/deposit", :to => "operation#create"
  post "/accounts/:account_number/operations/withdraw", :to => "operation#create"
  get "/accounts/:account_number/operations", :to => "operation#index"
end