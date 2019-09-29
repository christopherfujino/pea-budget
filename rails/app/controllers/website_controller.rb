class WebsiteController < ApplicationController
  def index
    @accounts = Account.all
  end
end
