class Stream < ApplicationRecord
  belongs_to :user

  has_many :outputs, dependent: :destroy
end
