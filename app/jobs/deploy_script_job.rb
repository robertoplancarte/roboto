class DeployScriptJob < ApplicationJob
  queue_as :default

  def perform(execution)
    Net::SSH.start(execution.environment.fqdn, execution.environment.user_name, keys: [execution.environment.private_key_path]) do |ssh|
      File.open("scripts/#{execution.script.file_name}", 'w') { |file| file.write(execution.script.code) }
      command = "scp  #{execution.script.path_to_application}/scripts/#{execution.script.file_name}  #{execution.environment.user_name}@#{execution.environment.fqdn}:~/scripts/"
      ssh.execute!(command, execution)
    end
  end
end
