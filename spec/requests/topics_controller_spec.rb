# spec/controllers/topics_controller_spec.rb
require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      topic = create(:topic)
      get :show, params: { id: topic.id }
      expect(response).to render_template('show')
    end
  end

  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    it "renders the edit template" do
      topic = create(:topic)
      get :edit, params: { id: topic.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #create" do
    it "creates a new topic" do
      expect {
        post :create, params: { topic: { title: "New Topic" } }
      }.to change(Topic, :count).by(1)
    end
  end



  describe "DELETE #destroy" do
    it "destroys the topic" do
      topic = create(:topic)
      expect {
        delete :destroy, params: { id: topic.id }
      }.to change(Topic, :count).by(-1)
    end
  end
  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to have_http_status(200) # 200 OK
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      topic = Topic.create(title: "Test Topic", author: "Test content")
      get :show, params: { id: topic.id }
      expect(response).to have_http_status(200) # 200 OK
    end
  end

  describe "GET #new" do
    it "returns a successful response" do
      get :new
      expect(response).to have_http_status(200) # 200 OK
    end
  end

  describe "GET #edit" do
    it "returns a successful response" do
      topic = Topic.create(title: "Test Topic", author: "Test content")
      get :edit, params: { id: topic.id }
      expect(response).to have_http_status(200) # 200 OK
    end
  end

  describe "POST #create" do
    it "returns a successful response" do
      post :create, params: { topic: { title: "New Topic", author: "New content" } }
      expect(response).to have_http_status(302) # 302 Found (assuming a redirect after create)
    end
  end

  describe "PATCH #update" do
    it "returns a successful response" do
      topic = Topic.create(title: "Test Topic", author: "Test content")
      patch :update, params: { id: topic.id, topic: { title: "Updated Title" } }
      expect(response).to have_http_status(302) # 302 Found (assuming a redirect after update)
    end
  end

  describe "DELETE #destroy" do
    it "returns a successful response" do
      topic = Topic.create(title: "Test Topic", author: "Test content")
      delete :destroy, params: { id: topic.id }
      expect(response).to have_http_status(302) # 302 Found (assuming a redirect after delete)
    end
  end
  describe "POST #create" do
    context "with valid parameters" do
      it "sets a success flash notice" do
        post :create, params: { topic: { title: "Valid Title", author: "Valid Content" } }
        expect(flash[:notice]).to eq("Topic was successfully created.")
      end
    end
    context "with invalid parameters" do
      it "redirects to the new topic page" do
        post :create, params: { topic: { title: "", content: "" } }
        expect(response).to redirect_to(new_topic_path)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      it "sets a success flash notice" do
        topic = Topic.create(title: "Initial Title", author: "Initial Content")
        patch :update, params: { id: topic.id, topic: { title: "Updated Title" } }
        expect(flash[:notice]).to eq("Topic was successfully updated.")
      end
    end
  end

  describe "DELETE #destroy" do
    it "sets a success flash notice" do
      topic = Topic.create(title: "Title to Delete", author: "Content to Delete")
      delete :destroy, params: { id: topic.id }
      expect(flash[:notice]).to eq("Topic was successfully deleted.")
    end
  end
end
