json.extract! execution, :id, :aasm_state, :started_at, :finished_at, :input, :stdout_data, :stderr_data, :user_id, :environment_id, :created_at, :updated_at
json.url execution_url(execution, format: :json)
