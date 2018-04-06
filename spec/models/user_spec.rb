require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should have_many(:downloads).dependent(:destroy) }
  it { should have_many(:streams).dependent(:destroy) }
end
