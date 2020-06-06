class Environment < ApplicationRecord
  has_many :executions, dependent: :destroy
end
