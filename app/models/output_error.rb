class OutputError < ApplicationRecord
  belongs_to :download

  validates :message, presence: true
end
