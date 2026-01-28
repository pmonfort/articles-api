require "rails_helper"

RSpec.describe Api::CommentsController, type: :controller do
  describe "POST #create" do
    let(:article) { create(:article) }

    context "with valid parameters" do
      let(:valid_attributes) do
        {
          comment: {
            body: "Test comment body",
            author_name: "Test Commenter",
            article_id: article.id
          }
        }
      end

      it "creates a new comment" do
        expect do
          post :create, params: valid_attributes
        end.to change(Comment, :count).by(1)
      end

      it "returns a created status" do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
      end

      it "returns the created comment" do
        post :create, params: valid_attributes
        json_response = JSON.parse(response.body)

        expect(json_response["body"]).to eq("Test comment body")
        expect(json_response["author_name"]).to eq("Test Commenter")
        expect(json_response["article_id"]).to eq(article.id)
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) do
        {
          comment: {
            body: "",
            author_name: "",
            article_id: article.id
          }
        }
      end

      it "does not create a new comment" do
        expect do
          post :create, params: invalid_attributes
        end.not_to change(Comment, :count)
      end

      it "returns an unprocessable entity status" do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_content)
      end

      it "returns error messages" do
        post :create, params: invalid_attributes
        json_response = JSON.parse(response.body)

        expect(json_response).to have_key("errors")
        expect(json_response["errors"]).not_to be_empty
      end
    end

    context "with invalid article_id" do
      let(:invalid_attributes) do
        {
          comment: {
            body: "Test comment",
            author_name: "Test Author",
            article_id: 999_999
          }
        }
      end

      it "does not create a new comment" do
        expect do
          post :create, params: invalid_attributes
        end.not_to change(Comment, :count)
      end

      it "returns an unprocessable entity status" do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end
end
