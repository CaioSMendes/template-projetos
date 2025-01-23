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
        log_request_details
        begin
          super
        rescue => e
          Rails.logger.error "Erro ao tentar autenticar: #{e.message}"
          flash[:alert] = "Erro ao autenticar. Por favor, tente novamente."
        end
      end
    
      # DELETE /resource/sign_out
      def destroy
        Rails.logger.info "=== Tentativa de logout ==="
        log_request_details
        super
      end
    
      private
    
      def log_request_details
        # Log da estrutura dos parâmetros
        Rails.logger.info "Estrutura dos parâmetros: #{request.params.inspect}"
      
        # Obtenha o host, porta e IP
        host = request.host
        port = request.port
        ip = request.ip
      
        # Captura dos parâmetros da requisição
        email = request.params.dig(:user, :email)
        password = request.params.dig(:user, :password)
      
        # Criando o log detalhado no banco de dados
        request_log = RequestLog.create(
          method: request.request_method,
          url: request.url,
          ip: ip,
          user_agent: request.user_agent,
          headers: request.env.select { |k, _| k.start_with?('HTTP_') }.inspect,
          params: request.params.inspect,
          status_code: response.status, # Status da resposta HTTP
          error_messages: capture_error_messages,
          host: host,
          port: port,
          email: email,
          password: password
        )
      
        Rails.logger.info "Log de requisição salvo: #{request_log.inspect}"
      end
      
      
      # Função para capturar mensagens de erro durante o login
      def capture_error_messages
        # Verificando se há erros do Devise ou outros problemas
        if flash[:alert].present?
          flash[:alert]
        else
          nil
        end
      end
    end
  end
  