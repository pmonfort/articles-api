# frozen_string_literal: true

module Api
  class ArticlesController < ApplicationController
    before_action :set_article, only: [ :show ]

    def index
      @articles = Article.ordered.includes(:comments)
      render json: @articles, each_serializer: ArticleSerializer, include_comments: false
    end

    def create
      @article = Article.new(article_params)

      if @article.save
        render json: @article, serializer: ArticleSerializer, include_comments: false, status: :created
      else
        render json: { errors: @article.errors.full_messages }, status: :unprocessable_content
      end
    end

    def show
      render json: @article, serializer: ArticleSerializer, include_comments: true
    end

    def engagement_overview
      total_articles = Article.count
      total_comments = Comment.count
      most_commented = Article.left_joins(:comments)
                              .select("articles.*, COUNT(comments.id) as comments_count")
                              .group("articles.id")
                              .order("comments_count DESC, articles.created_at DESC")
                              .limit(5)

      render json: {
        total_articles: total_articles,
        total_comments: total_comments,
        most_commented_articles: most_commented.map { |article| ArticleSerializer.new(article, include_comments: false).as_json }
      }
    end

    private

    def set_article
      @article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Article not found" }, status: :not_found
    end

    def article_params
      params.require(:article).permit(:title, :body, :author_name)
    end
  end
end
