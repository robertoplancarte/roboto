class Execution < ApplicationRecord
  belongs_to :user
  belongs_to :environment
  belongs_to :script
  has_many :execution_plans

  def duration
    return nil if finished_at.nil?

    (finished_at - started_at).seconds
  end
end
