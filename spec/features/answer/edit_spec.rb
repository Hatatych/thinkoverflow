require 'rails_helper'

feature 'User can edit an answer', %q{
  In order to correct mistakes
  As an author of answer
  Id like to be able to edit my answer
} do

  given!(:user) { create :user }
  given!(:question) { create :question }
  given!(:answer) { create :answer, question: question, author: user }

  scenario 'Unauthenticated user cant edit answer' do
    visit question_path(question)
    expect(page).not_to have_link 'Edit'
  end

  describe 'Authenticated user' do
    scenario 'edits his answer', js: true do
      sign_in(user)
      visit question_path(question)

      click_on 'Edit'

      within '.answers' do
        fill_in 'Your answer:', with: 'edited text'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited text'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'tries to edit other users answer'
    scenario 'tries to edit with errors'
  end
end
