require 'rails_helper'

feature 'User can sign out', %q{
  In order to quit session
  As an authenticated user
  Id like to be able to sign out
} do
  given(:user) { create :user }

  scenario 'Authenticated user tries to sign out' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    visit root_path
    click_on 'Log out'

    expect(page).to have_content 'Signed out successfully.'
  end

  scenario 'Unauthenticated user doesnt see sign out link' do
    visit root_path

    expect(page).to_not have_content 'Log out'
  end
end
