class TransactionsController < ApplicationController
  def new
  end

  def create
  end

  def index
    @transactions = Transaction.all
  end

  def update
  end

  def destroy
  end

  def show
  end
end
