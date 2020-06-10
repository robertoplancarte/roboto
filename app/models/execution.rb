class Execution < ApplicationRecord
  has_paper_trail only: [:aasm_state]
  belongs_to :user
  belongs_to :environment
  belongs_to :script
  has_many :execution_plans
  
  USER_EVENTS = %i(approve reset).freeze
  
  include AASM

  aasm do
    before_all_events :before_all_events
    state :new, initial: true
    state :approved, after_enter: :schedule_job
    state :reset_model, after_enter: :reset_all
    state :disapproved
    state :expired
    state :running
    state :succeeded
    state :failed

    event :reset do
      transitions to: :reset_model
    end

    event :approve do
      transitions from: :new, to: :expired, if: :expired?
      transitions from: :new, to: :approved
      transitions from: :reset_model, to: :expired, if: :expired?
      transitions from: :reset_model, to: :approved
    end

    event :disapprove do
      transitions from: :new, to: :disapproved
      transitions from: :reset_model, to: :disapproved
    end

    event :expire do
      transitions from: :new, to: :expired
      transitions from: :reset_model, to: :expired
    end

    event :start do
      transitions from: :approved, to: :running
    end

    event :finish do
      transitions from: :running, to: :succeeded, if: :exit_code_is_zero?
      transitions from: :running, to: :failed
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

  def exit_code_is_zero?
    exit_code.to_i.zero?
  end

  def reset_all
    update(started_at: nil, finished_at: nil, stdout_data: nil, stderr_data: nil)
  end

  def before_all_events
    self.paper_trail_event = aasm.current_event
  end
end
