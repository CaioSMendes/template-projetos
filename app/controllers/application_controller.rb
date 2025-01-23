class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :load_logs

  def load_logs
    @logs = File.readlines("log/detailed_requests.log").last(100) rescue []
  end
end
