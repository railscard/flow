class Output < ApplicationRecord
  belongs_to :download
  belongs_to :stream

  validates :line, presence: true
  validates :content, presence: true
  validates :responce, presence: true
end
