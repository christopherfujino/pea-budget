class AccountsController < ApplicationController
  def create
  end

  def index
    @accounts = Account.all
  end

  def show
    @account = Account.find(params[:account_id])
  end

  def update
  end

  def destroy
  end
end
