require 'rails_helper'

feature 'Create new stream', type: :feature, js: true do
  before do
    @user = create(:user)
    login_as(@user, scope: :user)

    visit '/'

    fill_in('stream_name', with: 'Process_1')
    click_button('Create')
  end

  it 'redirect user to new stream page' do
    expect(page.current_path).to eq("/stream/#{Stream.find_by(user_id: @user.id).id}")
  end

  it 'show correct stream name' do
    expect(page).to have_text('Process_1')
  end

  it 'have javascript placeholder' do
    expect(page).to have_text('process(input)')
  end

  it 'add new stream to streams list' do
    visit '/'
    expect(page).to have_text('Process_1')
  end
end

feature 'Check stream validity', type: :feature, js: true do
  before do
    @user = create(:user)
    @stream = create(:stream, user: @user)
    @stream_invalid = create(:stream, :invalid_code)

    login_as(@user, scope: :user)
  end

  it 'input enabled with valid javascript and file' do
    visit "/stream/#{@stream.id}"
    attach_file Rails.root.join('spec/support/fixtures/comma.csv')
    expect(page).to have_button('Process', disabled: false)
  end

  it 'input disabled without csv attached' do
    visit "/stream/#{@stream.id}"
    expect(page).to have_button('Process', disabled: true)
  end

  it 'input disabled with invalid javascript' do
    visit "/stream/#{@stream_invalid.id}"
    attach_file Rails.root.join('spec/support/fixtures/comma.csv')
    expect(page).to have_button('Process', disabled: true)
  end

end

feature 'Update stream', type: :feature, js: true do
  before do
    @user = create(:user)
    @stream = create(:stream, user: @user)

    login_as(@user, scope: :user)
    visit "/stream/#{@stream.id}"
    attach_file Rails.root.join('spec/support/fixtures/comma.csv')
    click_button('Process')
  end

  it 'redirect user to download page' do
    expect(page.current_path).to eq("/download/#{Download.find_by(stream_id: @stream.id).id}")
    expect(page).to_not have_text('Errors')
  end

  it 'add new file to history page' do
    visit '/download/'
    expect(page).to have_text('comma.csv')
  end
end

feature 'Delete stream', type: :feature, js: true do
  before do
    login_as(@user, scope: :user)
  end

  before(:all) do
    @user = create(:user)
    @stream = create(:stream, user: @user)
    @stream2 = create(:stream, user: @user)

    login_as(@user, scope: :user)

    visit "/stream/#{@stream.id}"
    attach_file Rails.root.join('spec/support/fixtures/comma.csv')
    click_button('Process')

    visit "/stream/#{@stream2.id}"
    attach_file Rails.root.join('spec/support/fixtures/pipe.csv')
    click_button('Process')
    visit '/'

    click_link('Delete', :match => :first)
  end

  it 'remove stream from streams page' do
    expect(page).to_not have_link("#{@stream2.name}")
  end

  it 'remove file from history page' do
    expect(page).to_not have_link("#{@stream2.name}")
  end

  it 'remove matching downloads' do
    expect(Download.find_by(stream_id: @stream2.id)).to be_nil
    visit '/download/'
    expect(page).to_not have_text('pipe.csv')
  end

  it 'not touch another downloads' do
    expect(Download.find_by(stream_id: @stream.id)).to_not be_nil
    visit '/download/'
    expect(page).to have_text('comma.csv')
  end
end

