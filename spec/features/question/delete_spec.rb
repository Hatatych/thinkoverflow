require 'rails_helper'

feature 'User can delete a question', %q{
  In order to stop recieving answers
  As an authenticated User
  Id like to bo able to delete my own question
} do

  scenario 'Author of question tries to delete question'
  scenario 'User tries to delete other users question'
end
