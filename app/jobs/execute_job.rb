class ExecuteJob < ApplicationJob
  queue_as :default

  def perform(execution)
    execution.update(started_at: Time.now)
    execution.start!
    DeployScriptJob.perform_now(execution)
    sleep(1) # let previous ssh session finish
    Net::SSH.start(execution.environment.fqdn, execution.environment.user_name, keys: [execution.environment.private_key_path]) do |ssh|
      if execution.script.nil?
      command = "cd #{execution.script.path_to_application}
                 RAILS_ENV=#{execution.environment.name} #{execution.script.command} #{execution.input}"
      else
      command = "cd #{execution.script.path_to_application}
                 RAILS_ENV=#{execution.environment.name} #{execution.script.command} ~/scripts/#{execution.script.file_name} #{execution.input}"
      end
      ssh.execute!(command, execution)
    end
  ensure
    execution.update(finished_at: Time.now)
    execution.finish!
  end
end
