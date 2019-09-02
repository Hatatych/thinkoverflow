require 'rails_helper'

feature 'User can delete a question', %q{
  In order to stop recieving answers
  As an authenticated User
  Id like to bo able to delete my own question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given(:other_question) { create(:question) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'Author of question tries to delete question' do
    click_on 'Delete'
    expect(current_path).to eq questions_path
    expect(page).not_to have_content question.title
  end

  scenario 'User tries to delete someone elses question' do
    visit question_path(other_question)
    expect(page).not_to have_content 'Delete'
  end
end
