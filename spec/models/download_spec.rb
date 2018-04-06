require 'rails_helper'

RSpec.describe Download, type: :model do
  it { should validate_presence_of(:name) }
  it { should belong_to(:user) }
  it { should have_many(:outputs).dependent(:destroy) }
end
