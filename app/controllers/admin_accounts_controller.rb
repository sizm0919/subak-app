class AdminAccountsController < ApplicationController
  def index
    @admin_accounts = Account.all
  end
end
