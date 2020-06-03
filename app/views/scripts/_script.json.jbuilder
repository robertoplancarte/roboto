json.extract! script, :id, :title, :code, :aasm_state, :path_to_application, :command, :created_at, :updated_at
json.url script_url(script, format: :json)
