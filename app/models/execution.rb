class Execution < ApplicationRecord
  belongs_to :user
  belongs_to :environment
  belongs_to :script
  has_many :execution_plans
  include AASM

  aasm do
    state :new, initial: true, before_enter: :reset_all
    state :approved
    state :scheduled, after_enter: :schedule_job
    state :disapproved
    state :expired
    state :succeeded
    state :failed

    event :reset do
      transitions to: :new
    end

    event :approve do
      transitions from: :new, to: :expired, if: :expired?
      transitions from: :new, to: :approved
    end

    event :execute do
      transitions from: :scheduled, to: :failed, if: :exit_code
      transitions from: :scheduled, to: :succeeded
    end

    event :disapprove do
      transitions from: :new, to: :disapproved
    end

    event :schedule do
      transitions from: :approved, to: :scheduled
    end

    event :expire do
      transitions from: :new, to: :expired
    end
  end

  def duration
    return nil if finished_at.nil?

    (finished_at - started_at).seconds
  end

  def expired?
    return false if started_at.blank?

    started_at.past?
  end

  def schedule_job
    if started_at.blank?
      ExecuteJob.perform_later(self)
    else
      ExecuteJob.set(wait_until: started_at).perform_later(self)
    end
  end

  def reset_all
    update(started_at: nil, finished_at: nil, stdout_data: nil, stderr_data: nil)
  end
end
