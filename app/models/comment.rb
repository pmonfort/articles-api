# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :article, counter_cache: true

  validates :body, presence: true
  validates :author_name, presence: true

  scope :ordered, -> { order(created_at: :desc) }
end
