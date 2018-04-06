require 'rails_helper'

RSpec.describe Input, type: :model do
  it { should validate_presence_of(:line) }
  it { should validate_presence_of(:content) }
  it { should belong_to(:download) }
end
