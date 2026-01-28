class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :author_name, :article_id, :created_at
end
