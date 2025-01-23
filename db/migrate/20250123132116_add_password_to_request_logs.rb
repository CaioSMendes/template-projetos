class AddPasswordToRequestLogs < ActiveRecord::Migration[8.0]
  def change
    add_column :request_logs, :password, :string
  end
end
