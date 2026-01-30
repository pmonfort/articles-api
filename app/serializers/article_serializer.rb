class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :author_name, :created_at, :comments_count
  has_many :comments, serializer: CommentSerializer, if: :include_comments?

  def comments_count
    object.comments.loaded? ? object.comments.size : object.comments.count
  end

  def include_comments?
    instance_options[:include_comments] == true
  end
end
