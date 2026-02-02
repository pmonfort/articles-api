# frozen_string_literal: true

module Api
  class ArticlesController < ApplicationController
    before_action :set_article, only: [ :show ]

    MOST_COMMENTED_ARTICLES_QUANTITY = 5

    def index
      @articles = Article.ordered
      render json: @articles
    end

    def create
      @article = Article.new(article_params)

      if @article.save
        render json: @article, status: :created
      else
        render json: { errors: @article.errors.full_messages }, status: :unprocessable_content
      end
    end

    def show
      render json: @article, include: :comments
    end

    def engagement_overview
      total_articles = Article.count
      total_comments = Comment.count
      most_commented = Article.order(comments_count: :desc, created_at: :desc)
                              .limit(MOST_COMMENTED_ARTICLES_QUANTITY)

      render json: {
        total_articles: total_articles,
        total_comments: total_comments,
        most_commented_articles: most_commented
      }
    end

    private

    def set_article
      @article = Article.includes(:comments).find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Article not found" }, status: :not_found
    end

    def article_params
      params.require(:article).permit(:title, :body, :author_name)
    end
  end
end
