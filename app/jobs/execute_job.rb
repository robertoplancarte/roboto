class ExecuteJob < ApplicationJob
  queue_as :default

  def perform(execution)
    execution.update(started_at: Time.now)
    output = []
    file_name = "#{execution.script.id}_#{execution.script.title.underscore.split(' ').join('_')}"
    Net::SSH.start(execution.environment.fqdn, execution.environment.user_name, keys: [execution.environment.private_key_path]) do |ssh|
      File.open("scripts/#{file_name}", 'w') { |file| file.write(execution.script.code) }
      command = "scp  #{execution.script.path_to_application}/scripts/#{file_name}  #{execution.environment.user_name}@#{execution.environment.fqdn}:~/scripts/"
      output << ssh.exec!(command)

      command = "cd #{execution.script.path_to_application} && RAILS_ENV=#{execution.environment.name} #{execution.script.command} ~/scripts/#{file_name} #{execution.input}"
      output << ssh.exec!(command)
      execution.update(output: output.join(' ').split("\n").reject { |x| x.match(/Running via Spring/) }.join('\n'))
    end
  ensure
    execution.update(finished_at: Time.now)
  end
end
