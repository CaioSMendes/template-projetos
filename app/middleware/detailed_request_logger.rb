class DetailedRequestLogger
    def initialize(app)
      @app = app
    end
  
    def call(env)
      request = Rack::Request.new(env)
  
      Rails.logger.info "================= NOVA REQUISIÇÃO ================="
      Rails.logger.info "Método: #{request.request_method}"
      Rails.logger.info "URL: #{request.url}"
      Rails.logger.info "Porta: #{request.port}"
      Rails.logger.info "IP do cliente: #{request.ip}"
      Rails.logger.info "User-Agent: #{request.user_agent}"
      Rails.logger.info "Cookies: #{request.cookies.inspect}"
      Rails.logger.info "Cabeçalhos: #{env.select { |k, _| k.start_with?('HTTP_') }}"
      Rails.logger.info "Parâmetros: #{request.params.inspect}"
      Rails.logger.info "==================================================="
  
      status, headers, response = @app.call(env)
  
      Rails.logger.info "================= RESPOSTA ================="
      Rails.logger.info "Status HTTP: #{status}"
      Rails.logger.info "Cabeçalhos de Resposta: #{headers.inspect}"
      Rails.logger.info "==================================================="
  
      [status, headers, response]
    rescue StandardError => e
      Rails.logger.error "Erro durante a requisição: #{e.message}"
      raise
    end
end
  