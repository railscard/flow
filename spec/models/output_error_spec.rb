require 'rails_helper'

RSpec.describe OutputError, type: :model do
  it { should belong_to(:download) }
  it { should validate_presence_of(:message) }
end
