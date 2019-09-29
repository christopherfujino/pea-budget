class CsvsController < ApplicationController
  def new
    @csv = Csv.new
    @accounts = Account.all
  end

  def create
    csv = Csv.create!(params.require(:csv).permit(:account_id, :csv_file))
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
    @csv_string = @csv.csv_file.download
    @csv_matrix = CSV.parse(@csv_string)
    print(@csv_matrix)
  end
end
