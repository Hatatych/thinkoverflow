require 'rails_helper'

feature 'User can delete an answer', %q{
  In order to revoke opinion
  As an author of answer
  Id like to be able to delete it
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:second_question) { create(:question) }
  given(:my_answer) { create(:answer, question: question, author: user) }
  given(:other_answer) { create(:answer, question: second_question) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'Author of answer tries to delete an answer' do
    expect(page).to have_content my_answer.body
    click_on 'Delete'
    expect(page).not_to have_content my_answer.body
  end
  
  scenario 'User tries to delete other answer'
end
