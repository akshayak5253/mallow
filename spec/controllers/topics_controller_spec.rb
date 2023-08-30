require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    let(:topic) { create(:topic) }

    it "renders the show template" do
      get :show, params: { id: topic.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    it "creates a new topic" do
      expect {
        post :create, params: { topic: { title: "New Topic", author: "John Doe" } }
      }.to change(Topic, :count).by(1)
    end
  end

  describe "GET #edit" do
    let(:topic) { create(:topic) }

    it "renders the edit template" do
      get :edit, params: { id: topic.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    let!(:topic) { create(:topic) }

    it "updates the topic" do
      patch :update, params: { id: topic.id, topic: { title: "Updated Title" } }
      topic.reload
      expect(topic.title).to eq("Updated Title")
    end
  end

  describe "DELETE #destroy" do
    let!(:topic) { create(:topic) }

    it "destroys the topic" do
      expect {
        delete :destroy, params: { id: topic.id }
      }.to change(Topic, :count).by(-1)
    end
  end
end
