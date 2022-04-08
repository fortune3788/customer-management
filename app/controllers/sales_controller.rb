class SalesController < ApplicationController
  #before_action :correct_client, only: [:show]
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @client = Client.find(params[:client_id])
    @sale = Sale.new
    @pagy, @sales = pagy(@client.sales.order(id: :desc))
    # if params[:client_id].present?
    #   Sale.where(user_id: current_user.id, client_id: params[:client_id])
    # else
    #   Sale.where(user_id: current_user.id)
    # end
  end
  
  def show
    @client = Client.find(params[:client_id])
    @sale = @client.sales.find(params[:id])
  end
  
  def create
    client = Client.find(params[:client_id])
    @sale = client.sales.build(sale_params)
    
    if @sale.save
      flash[:success] = '売上情報を登録しました'
      redirect_to client_sales_path
    else
      @client = Client.find(params[:client_id])
      @pagy, @sales = pagy(@client.sales.order(id: :desc))
      flash.now[:danger] = '売上情報の登録に失敗しました'
      render 'sales/index'
    end
  end
  
  def update
    client = Client.find(params[:client_id])
    @sale = client.sales.find_by(id: params[:id])
    
    if @sale.update(sale_params)
      flash[:success] = '売上情報を変更しました'
      redirect_to client_sales_path
    else
      flash.now[:danger] = '売上情報の変更に失敗しました'
      render 'sales/show'
    end
  end
  
  def destroy
    client = Client.find(params[:client_id])
    @sale = client.sales.find_by(id: params[:id])
    
    @sale.destroy
    flash[:success] = 'この売上情報を削除しました'
    redirect_to client_sales_path
  end
  
  private
  
  #def correct_client
  #  @client = Client.find(params[:client_id])
  #  @sale = @client.sales.find_by(id: params[:id])
  #  unless @sale
  #    redirect_to root_url
  #  end
  #end
  
  def sale_params
    params.require(:sale).permit(:date, :item, :item_quantity)#.merge(client_id: params[:id])
  end
  
end
