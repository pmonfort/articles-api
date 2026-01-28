# frozen_string_literal: true

module Api
  class CommentsController < ApplicationController
    def create
      comment = Comment.new(comment_params)

      if comment.save
        render json: comment, serializer: CommentSerializer, status: :created
      else
        render json: { errors: comment.errors.full_messages }, status: :unprocessable_content
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:body, :author_name, :article_id)
    end
  end
end
