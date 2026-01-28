# frozen_string_literal: true

module Api
  class ArticlesController < ApplicationController
    before_action :set_article, only: [:show]

    def index
      @articles = Article.ordered.includes(:comments)
      render json: @articles, each_serializer: ArticleSerializer
    end

    def create
      @article = Article.new(article_params)

      if @article.save
        render json: @article, serializer: ArticleSerializer, status: :created
      else
        render json: { errors: @article.errors.full_messages }, status: :unprocessable_content
      end
    end

    def show
      render json: @article, serializer: ArticleSerializer
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
