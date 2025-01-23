class HomeController < ApplicationController
  before_action :authenticate_user! # Garante que apenas usuários autenticados possam acessar

  def index
    if current_user.admin? # Verifica se o usuário é admin
      redirect_to admin_index_path, notice: "Bem-vindo, Admin!"
    elsif current_user.user? # Verifica se o usuário é um usuário comum
      redirect_to user_index_path, notice: "Bem-vindo, Usuário!"
    else
      redirect_to root_path, alert: "Acesso não autorizado!"
    end
  end
end
