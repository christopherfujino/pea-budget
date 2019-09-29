class CsvsController < ApplicationController
  def new
    @csv = Csv.new
    @accounts = Account.all
  end

  def create
    csv = Csv.create(params.require(:csv).permit(:account_id))
    redirect_to action: :show, csv_id: csv.id
  end

  def index
    @csvs = Csv.all
  end

  def update
  end

  def destroy
    csv = Csv.find(params[:csv_id])
    csv.destroy
    redirect_to action: :index
  end

  def show
    @csv = Csv.find(params[:csv_id])
  end
end
