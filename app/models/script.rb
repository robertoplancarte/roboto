class Script < ApplicationRecord
  before_update :edit, unless: :aasm_state_changed?
  has_many :executions, dependent: :destroy
  include AASM

  aasm do
    state :new, initial: true
    state :untested
    state :tested
    state :deployed

    event :test do
      transitions to: :tested
    end

    event :edit do
      transitions to: :untested
    end

    event :deploy do
      transitions from: :tested, to: :deployed
    end
  end

  def file_name
    "#{id}_#{title.underscore.split(' ').join('_')}"
  end
end
