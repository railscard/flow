class Download < ApplicationRecord
  belongs_to :user

  has_many :inputs, dependent: :destroy
  has_many :outputs, dependent: :destroy
  has_many :output_errors, dependent: :destroy

  validates :name, presence: true

  def self.prettify(arr)
    arr = arr.map do |el|
        JSON.parse(el.content)
    end

    JSON.pretty_generate(arr.flatten)
  end
end
