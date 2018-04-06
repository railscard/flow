require 'rails_helper'

RSpec.describe 'FactoryBot Linting' do
  it 'checked all factories' do
    FactoryBot.lint traits: true
  end
end