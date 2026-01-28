# frozen_string_literal: true

class Article < ApplicationRecord
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :author_name, presence: true

  scope :ordered, -> { order(created_at: :desc) }
end
