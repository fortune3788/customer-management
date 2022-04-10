class ClientsController < ApplicationController
  before_action :correct_user, only: [:destroy, :update]
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @client = current_user.clients.build
    @pagy, @clients = pagy(current_user.clients.order(id: :desc))
  end
  
  def show
    @client = current_user.clients.find_by(id: params[:id])
  end
  
  def create
    @client = current_user.clients.build(client_params)
    if @client.save
      flash[:success] = '新しい顧客を追加しました'
      redirect_to clients_path
    else
      @pagy, @clients = pagy(current_user.clients.order(id: :desc))
      flash.now[:danger] = '顧客の登録に失敗しました'
      render 'clients/index'
    end
  end
  
  def update
    if @client.update(client_params)
      flash[:success] = '顧客の名前を編集しました'
      redirect_to clients_path
    else
      flash.now[:danger] = '顧客の名前の編集に失敗しました'
      render 'clients/show'
    end
  end
  
  def destroy
    @client.destroy
    flash[:success] = 'この顧客を削除しました'
    redirect_to clients_path
  end
  
  private
  
  def client_params
    params.require(:client).permit(:name)
  end
  
  def correct_user
    @client = current_user.clients.find_by(id: params[:id])
    unless @client
      redirect_to root_url
    end
  end
end
