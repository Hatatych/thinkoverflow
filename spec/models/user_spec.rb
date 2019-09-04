require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :username }

  describe 'author?' do
    let(:first_user) { create :user }
    let(:second_user) { create :user }
    let(:question) { create :question }
    let(:first_answer) { create :answer, question: question, author: first_user }
    let(:second_answer) { create :answer, question: question, author: second_user }

    it { expect(first_user.author?(first_answer)).to be_truthy }
    it { expect(first_user.author?(second_answer)).to be_falsey }
  end
end
