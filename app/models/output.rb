class Output < ApplicationRecord
  belongs_to :download

  validates :line, presence: true
  validates :content, presence: true
  validates :responce, presence: true
end
