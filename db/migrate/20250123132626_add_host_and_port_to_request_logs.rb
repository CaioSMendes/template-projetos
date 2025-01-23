class AddHostAndPortToRequestLogs < ActiveRecord::Migration[8.0]
  def change
    add_column :request_logs, :host, :string
  end
end
