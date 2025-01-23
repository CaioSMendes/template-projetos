class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    # Lógica para o admin
  end

  private

  def check_admin
    redirect_to root_path, alert: "Acesso não autorizado!" unless current_user.admin?
  end
end
