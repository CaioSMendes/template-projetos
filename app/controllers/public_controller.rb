class PublicController < ApplicationController
  def logs
    @request_logs = RequestLog.all  # ou outro método para obter os logs
  end
end
