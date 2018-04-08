require 'rails_helper'

RSpec.describe Stream, type: :model do
  before(:all) do
    @user              = create(:user)
    @download          = create(:download, user: @user)
    @stream            = create(:stream, user: @user)
    @stream_invalid    = create(:stream, :invalid_code, user: @user)
    @file              = fixture_file_upload('spec/support/fixtures/comma.csv', 'text/csv')
    @file_empty_fields = fixture_file_upload('spec/support/fixtures/empty_fields.csv', 'text/csv')
    @file_tab          = fixture_file_upload('spec/support/fixtures/tab.csv', 'text/csv')
    @file_pipe         = fixture_file_upload('spec/support/fixtures/pipe.csv', 'text/csv')
    @file_semicolon    = fixture_file_upload('spec/support/fixtures/semicolon.csv', 'text/csv')
  end

  it { should validate_presence_of(:name) }
  it { should belong_to(:user) }
  it { should have_many(:downloads).dependent(:destroy) }

  describe '.process' do
    it 'creates new inputs for each line of csv' do
      @stream.process(@file, @download.id)
      expect(@download.inputs.count).to eq(4)
    end

    it 'creates new outputs for each line of csv' do
      @stream.process(@file, @download.id)
      expect(@download.outputs.count).to eq(4)
    end

    it 'parses csv with empty fields correctly' do
      @stream.process(@file_empty_fields, @download.id)
      expect(@download.inputs.first.content).to eq('{"last_name":"McAllister","dogs":2,"birds":2,"fish":4}')
    end

    it 'parses csv with pipe separators correctly' do
      @stream.process(@file_pipe, @download.id)
      expect(@download.inputs.first.content).to eq('{"first_name":"Dan","last_name":"McAllister","dogs":2,"cats":1,"birds":2,"fish":4}')
    end

    it 'parses csv with semicolon separators correctly' do
      @stream.process(@file_semicolon, @download.id)
      expect(@download.inputs.first.content).to eq('{"first_name":"Dan","last_name":"McAllister","dogs":2,"cats":1,"birds":2,"fish":4}')
    end

    it 'parses csv with tab separators correctly' do
      @stream.process(@file_tab, @download.id)
      expect(@download.inputs.first.content).to eq('{"first_name":"Dan","last_name":"McAllister","dogs":2,"cats":1,"birds":2,"fish":4}')
    end
  end
end
