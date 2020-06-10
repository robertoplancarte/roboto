class ExecutionChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'card'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
