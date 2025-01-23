class AddStatusCodeAndErrorMessagesToRequestLogs < ActiveRecord::Migration[8.0]
  def change
    add_column :request_logs, :status_code, :integer
    add_column :request_logs, :error_messages, :text
  end
end
