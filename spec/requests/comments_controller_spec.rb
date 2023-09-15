# spec/controllers/comments_controller_spec.rb

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all comments as @comments' do
      comment = FactoryBot.create(:comment)
      get :index
      expect(assigns(:comments)).to eq([comment])
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      comment = FactoryBot.create(:comment)
      get :show, params: { id: comment.id }
      expect(response).to be_successful
    end

    it 'assigns the requested comment as @comment' do
      comment = FactoryBot.create(:comment)
      get :show, params: { id: comment.id }
      expect(assigns(:comment)).to eq(comment)
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end

    it 'assigns a new comment as @comment' do
      get :new
      expect(assigns(:comment)).to be_a_new(Comment)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new comment' do
        expect do
          post :create, params: { comment: FactoryBot.attributes_for(:comment) }
        end.to change(Comment, :count).by(1)
      end

      it 'redirects to the created comment' do
        post :create, params: { comment: FactoryBot.attributes_for(:comment) }
        expect(response).to redirect_to(Comment.last)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new comment' do
        expect do
          post :create, params: { comment: FactoryBot.attributes_for(:comment, content: nil) }
        end.not_to change(Comment, :count)
      end

      it 're-renders the new template' do
        post :create, params: { comment: FactoryBot.attributes_for(:comment, content: nil) }
        expect(response).to render_template('new')
      end
    end
  end

  # Add similar tests for the other controller actions like edit, update, and destroy.
end
