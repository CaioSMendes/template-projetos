class CreateRequestLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :request_logs do |t|
      t.string :method
      t.string :url
      t.integer :port
      t.string :ip
      t.string :user_agent
      t.text :cookies
      t.text :headers
      t.text :params

      t.timestamps
    end
  end
end
