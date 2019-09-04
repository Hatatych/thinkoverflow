require 'rails_helper'

feature 'User can post an answer', %q{
  In order to give an answer
  As an authenticated User
  Id like to bo able to give an answer
} do

  given(:user) { create(:user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)

      create(:question)
      visit questions_path
      click_on 'MyString'
    end

    scenario 'posts an answer', js: true do
      fill_in 'Your answer', with: 'Sample text'
      click_on 'Go for it!'

      expect(page).to have_content 'Sample text'
    end

    scenario 'posts empty answer', js: true do
      click_on 'Go for it!'

      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Unauthenticated user tries to leave an answer' do
    create(:question)
    visit questions_path
    click_on 'MyString'
    expect(page).to_not have_content 'Go for it!'
  end
end
