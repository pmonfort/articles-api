require "rails_helper"

RSpec.describe Api::ArticlesController, type: :controller do
  describe "GET #show" do
    let!(:article) { create(:article_with_comments, comments_count: comments_qty) }
    let(:comments_qty) { rand(1..5) }

    it "returns a successful response" do
      get :show, params: { id: article.id }
      expect(response).to have_http_status(:success)
    end

    it "returns the article" do
      get :show, params: { id: article.id }
      json_response = JSON.parse(response.body)
      expect(json_response["id"]).to eq(article.id)
      expect(json_response["title"]).to eq(article.title)
      expect(json_response["body"]).to eq(article.body)
      expect(json_response["author_name"]).to eq(article.author_name)
      expect(json_response["comments"]).to be_present
      expect(json_response["comments_count"]).to eq(comments_qty)
    end

    it "returns a 404 status" do
      get :show, params: { id: 0 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns all articles with comments count" do
      article1 = create(:article_with_comments, comments_count: 2)
      article2 = create(:article_with_comments, comments_count: 1)

      get :index

      json_response = JSON.parse(response.body)

      expect(json_response.length).to eq(2)
      article1_response = json_response.find { |a| a["id"] == article1.id }
      article2_response = json_response.find { |a| a["id"] == article2.id }
      expect(article1_response["comments_count"]).to eq(2)
      expect(article2_response["comments_count"]).to eq(1)
    end

    it "includes article details" do
      article = create(:article)

      get :index
      json_response = JSON.parse(response.body)

      expect(json_response.first).to include(
        "id" => article.id,
        "title" => article.title,
        "body" => article.body,
        "author_name" => article.author_name,
        "comments_count" => article.comments.count
      )
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_attributes) do
        {
          article: {
            title: "Test Article",
            body: "Test body content",
            author_name: "Test Author"
          }
        }
      end

      it "creates a new article" do
        expect do
          post :create, params: valid_attributes
        end.to change(Article, :count).by(1)
      end

      it "returns a created status" do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
      end

      it "returns the created article" do
        post :create, params: valid_attributes
        json_response = JSON.parse(response.body)

        expect(json_response["title"]).to eq("Test Article")
        expect(json_response["body"]).to eq("Test body content")
        expect(json_response["author_name"]).to eq("Test Author")
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) do
        {
          article: {
            title: "",
            body: "",
            author_name: ""
          }
        }
      end

      it "does not create a new article" do
        expect do
          post :create, params: invalid_attributes
        end.not_to change(Article, :count)
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
  end

  describe "GET #engagement_overview" do
    let(:number_of_articles) { rand(10..15) }
    let(:number_of_comments) { rand(1..5) }
    let(:json_response) { JSON.parse(response.body) }
    let!(:articles) { create_list(:article_with_comments, number_of_articles, comments_count: number_of_comments) }

    it "returns engagement statistics" do
      get :engagement_overview

      expect(json_response["total_articles"]).to eq(number_of_articles)
      expect(json_response["total_comments"]).to eq(number_of_articles * number_of_comments)
      expect(json_response).to have_key("most_commented_articles")
    end

    it "returns most commented articles" do
      article1 = create(:article_with_comments, comments_count: 10)

      get :engagement_overview

      most_commented = json_response["most_commented_articles"]
      expect(most_commented.first["id"]).to eq(article1.id)
      expect(most_commented.first["comments_count"]).to eq(10)
    end
  end
end
