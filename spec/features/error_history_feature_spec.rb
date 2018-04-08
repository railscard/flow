require 'rails_helper'

feature 'User creates stream that causes error', type: :feature, js: true do
  before do
    @user   = create(:user)
    @stream = create(:stream,:wrong_variable, user: @user)

    login_as(@user, scope: :user)
    visit "/stream/#{@stream.id}"
    attach_file Rails.root.join('spec/support/fixtures/comma.csv')
    click_button('Process')
  end

  it 'redirect to download page that have list of errors' do
    expect(page.current_path).to eq('/download/1')
    expect(page).to have_text('Errors')
    expect(page).to have_text('output is not defined')
  end
end