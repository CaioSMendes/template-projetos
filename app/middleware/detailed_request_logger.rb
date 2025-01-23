class DetailedRequestLogger
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    # Logs da requisição
    logs = []
    logs << "================= NOVA REQUISIÇÃO ================="
    logs << "Método: #{request.request_method}"
    logs << "URL: #{request.url}"
    logs << "Porta: #{request.port}"
    logs << "IP do cliente: #{request.ip}"
    logs << "User-Agent: #{request.user_agent}"
    logs << "Cookies: #{request.cookies.inspect}"
    logs << "Cabeçalhos: #{env.select { |k, _| k.start_with?('HTTP_') }}"
    logs << "Parâmetros: #{request.params.inspect}"
    logs << "==================================================="

    Rails.logger.info logs.join("\n")

    # Chama o app e captura a resposta
    status, headers, response = @app.call(env)

    # Logs da resposta
    response_logs = []
    response_logs << "================= RESPOSTA DEVISE ================="
    response_logs << "Status HTTP: #{status}"
    response_logs << "Cabeçalhos de Resposta: #{headers.inspect}"
    response_logs << "==================================================="

    Rails.logger.info response_logs.join("\n")

    # Adiciona os logs como cabeçalho na resposta HTTP para o console JS
    headers['X-Detailed-Logs'] = (logs + response_logs).join(" | ")

    # Retorna a resposta ao cliente
    [status, headers, response]
  rescue StandardError => e
    Rails.logger.error "Erro durante a requisição: #{e.message}"
    raise
  end
end
