require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create :question }
  let(:answers) { create_list(:answer, 3, question: question) }
  let(:answer) { create :answer, question: question }
  let(:user) { create :user }

  describe 'GET #index' do
    let(:other_question) { create :question }
    let(:other_answers) { create_list(:answer, 3, question: other_question) }
    before { get :index, params: { question_id: question } }

    it 'populates an array of question answers' do
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'doesnt show other questions answers' do
      expect(assigns(:answers)).not_to include(:other_answers)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    before { get :new, params: { question_id: question } }

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: answers.first } }

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new answer to database' do
        login(user)
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question } }.to change(question.answers, :count).by(1)
      end

      it 'redirects to index' do
        login(user)
        post :create, params: { answer: attributes_for(:answer), question_id: question }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attributes' do
      it 'doesnt save answer to db' do
        login(user)
        expect { post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question } }.to_not change(Answer, :count)
      end

      it 're-renders question template' do
        login(user)
        post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question }
        expect(response).to render_template 'questions/show'
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'assigns found question to a variable' do
        patch :update, params: { id: answer, answer: attributes_for(:answer) }
        expect(assigns(:answer)).to eq answer
      end

      it 'updates answer with parameters' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'redirects to index' do
        post :update, params: { id: answer, answer: attributes_for(:answer) }
        expect(response).to redirect_to question_path(answer.question)
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) } }

      it 'doesnt update invalid answer' do
        answer.reload
        expect(answer.body).to eq 'MyText'
      end

      it 'rerenders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:answer) { create :answer, question: question, author: user }

    it 'deletes an answer' do
      login(user)
      expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(-1)
    end

    it 'redirects to index' do
      login(user)
      delete :destroy, params: { id: answer }
      expect(response).to redirect_to question_path(question)
    end
  end
end
