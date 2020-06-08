class Environment < ApplicationRecord
  has_many :executions, dependent: :destroy
  validates :name, presence: true
  validates :private_key_path, presence: true
  validates :user_name, presence: true
  validates :fqdn, presence: true
end
