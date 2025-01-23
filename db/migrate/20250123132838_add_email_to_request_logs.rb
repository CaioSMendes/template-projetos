class AddEmailToRequestLogs < ActiveRecord::Migration[8.0]
  def change
    add_column :request_logs, :email, :string
  end
end
