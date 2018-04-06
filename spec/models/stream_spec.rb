require 'rails_helper'

RSpec.describe Stream, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:code) }
  it { should belong_to(:user) }
  it { should have_many(:outputs).dependent(:destroy) }
end
