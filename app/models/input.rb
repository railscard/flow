class Input < ApplicationRecord
  belongs_to :download

  validates :line, presence: true
  validates :content, presence: true
end
