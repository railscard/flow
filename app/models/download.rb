class Download < ApplicationRecord
  belongs_to :user

  has_many :inputs, dependent: :destroy
  has_many :outputs, dependent: :destroy

  validates :name, presence: true
end
