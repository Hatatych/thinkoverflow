require 'rails_helper'

feature 'User can delete an answer', %q{
  In order to revoke opinion
  As an author of answer
  Id like to be able to delete it
} do

  given(:user) { create(:user) }
  given(:second_user) { create(:user) }
  given(:question) { create(:question) }

  background do
    sign_in(user)
    visit question_path(question)
    fill_in 'Your answer:', with: 'This shouldnt exist after delete'
    click_on 'Go for it!'
  end

  scenario 'Author deletes own answer' do
    expect(page).to have_content 'Delete'
    expect(page).to have_content 'This shouldnt exist after delete'
    click_on 'Delete'
    expect(page).not_to have_content 'This shouldnt exist after delete'
  end

  scenario 'User tries to delete other answer' do
    click_on 'Log out'
    sign_in(second_user)
    visit question_path(question)
    expect(page).not_to have_content 'Delete'
  end

  scenario 'Guest tries to delete an answer' do
    click_on 'Log out'
    visit visit question_path(question)
    expect(page).not_to have_content 'Delete'
  end
end
