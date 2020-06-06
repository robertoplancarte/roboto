class Script < ApplicationRecord
  has_many :executions, dependent: :destroy
end
