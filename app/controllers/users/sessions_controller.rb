module Users
    class Users::SessionsController < Devise::SessionsController
        # GET /resource/sign_in
        def new
          Rails.logger.info "=== Iniciando processo de login ==="
          log_request_details
          super
        end
      
        # POST /resource/sign_in
        def create
          Rails.logger.info "=== Tentativa de login ==="
          Rails.logger.info "Parâmetros recebidos: #{sign_in_params.inspect}"
      
          # Detalhes da requisição
          log_request_details
          
          email = sign_in_params[:email]
          password = sign_in_params[:password]
      
          Rails.logger.info "Buscando usuário no banco com email: #{email}"
          user = User.find_by(email: email)
      
          if user
            Rails.logger.info "Usuário encontrado no banco: #{user.inspect}"
            if user.valid_password?(password)
              Rails.logger.info "Senha correta para o usuário: #{user.email}"
              flash[:notice] = "Bem-vindo, #{user.email}!"
      
              # Logando login bem-sucedido
              Rails.logger.info "Login bem-sucedido para o usuário: #{user.email}"
      
              super do |user|
                Rails.logger.info "Sessão iniciada com sucesso para o usuário: #{user.email}"
              end
            else
              Rails.logger.error "Senha incorreta para o usuário: #{user.email}"
              flash[:alert] = "Erro ao autenticar. Por favor, verifique suas credenciais."
            end
          else
            Rails.logger.error "Usuário não encontrado com o email: #{email}"
            flash[:alert] = "Erro ao autenticar. Usuário não encontrado."
          end
        rescue StandardError => e
          Rails.logger.error "Erro durante o processo de login: #{e.message}"
          flash[:alert] = "Erro inesperado durante o login: #{e.message}"
          redirect_to new_user_session_path
        end
      
        # DELETE /resource/sign_out
        def destroy
          Rails.logger.info "=== Tentativa de logout ==="
          log_request_details
          super
          Rails.logger.info "Usuário desconectado com sucesso"
          flash[:notice] = "Você saiu com sucesso. Volte sempre!"
        end
      
        private
      
        def sign_in_params
          params.require(resource_name).permit(:email, :password, :remember_me)
        end
      
        # Método para logar detalhes da requisição
        def log_request_details
          request = request.env # Ou pode usar `Rack::Request.new(request.env)` se necessário
          
          Rails.logger.info "================= DETALHES DA REQUISIÇÃO ================="
          Rails.logger.info "Método: #{request.request_method}"
          Rails.logger.info "URL: #{request.url}"
          Rails.logger.info "Porta: #{request.port}"
          Rails.logger.info "IP do cliente: #{request.ip}"
          Rails.logger.info "User-Agent: #{request.user_agent}"
          Rails.logger.info "Cookies: #{request.cookies.inspect}"
          Rails.logger.info "Cabeçalhos: #{request.env.select { |k, _| k.start_with?('HTTP_') }.inspect}"
          Rails.logger.info "Parâmetros: #{request.params.inspect}"
          Rails.logger.info "=========================================================="
        end
    end      
end
  