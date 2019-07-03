require 'rails_helper'

feature 'User can sign up', %q{
  In order to ask questions
  As an authenticated user
  Id like to be able to register
} do
  given(:user) { create :user }

  describe 'Unauthenticated user' do
    background do
      visit new_user_registration_path
      fill_in 'Email', with: 'test01@example.com'
      fill_in 'Password', with: 'Mysecretpass123'
      fill_in 'Password confirmation', with: 'Mysecretpass123'
    end

    scenario 'tries to register with valid params' do
      click_on 'Sign up'

      expect(page).to have_content 'Welcome! You have signed up successfully.'
      expect(page).to have_content 'Log out'
    end

    scenario 'tries to register with invalid params' do
      fill_in 'Password confirmation', with: 'WrongConfirmation'
      click_on 'Sign up'

      expect(page).to have_content "Password confirmation doesn't match Password"
    end

    scenario 'tries to register with already existing params' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: user.password
      click_on 'Sign up'

      expect(page).to have_content 'Email has already been taken'
    end
  end

  scenario 'Authenticated user tries to access register page' do
    sign_in(user)

    visit new_user_registration_path
    expect(current_path).to eq root_path
  end
end
