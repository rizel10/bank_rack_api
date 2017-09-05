BankRackApplication.router.config do
  post "/account/:account_number/operations/deposit", :to => "operation#create"
  post "/account/:account_number/operations/withdraw", :to => "operation#create"
  get "/account/:account_number/operations", :to => "operation#index"
end