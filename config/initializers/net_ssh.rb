class Net::SSH::Connection::Session
  class CommandFailed < StandardError
  end

  class CommandExecutionFailed < StandardError
  end

  def execute!(command, execution)
    counter = 0
    exit_code = nil
    ssh = open_channel do |channel|
      channel.exec(command) do |_, success|
        raise CommandExecutionFailed, "Command \"#{command}\" was unable to execute" unless success

        channel.on_data do |_, data|
          execution.update stdout_data: "#{execution.stdout_data}#{data}" unless data.match(/Running via Spring/)
        end

        channel.on_extended_data do |_, _, data|
          execution.update stderr_data: "#{execution.stderr_data}#{data}" unless data.match(/Running via Spring/)
        end

        channel.on_request('exit-status') do |_, data|
          exit_code = data.read_long.to_i
        end

        channel.on_request('exit-signal') do |_, data|
          execution.update exit_signal: data.read_long.to_i
        end
      end
    end
    ssh.wait
    self.loop

    execution.update(exit_code: exit_code)
    #raise CommandFailed, "Command \"#{command}\" returned exit code #{exit_code}" unless exit_code.zero?
  end
end
