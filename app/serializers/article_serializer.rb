class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :author_name, :created_at, :comments_count
  has_many :comments, serializer: CommentSerializer

  def comments_count
    object.comments.count
  end
end
