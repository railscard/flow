require 'rails_helper'

RSpec.describe Output, type: :model do
  it { should validate_presence_of(:line) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:responce) }
  it { should belong_to(:download) }
  it { should belong_to(:stream) }
end
