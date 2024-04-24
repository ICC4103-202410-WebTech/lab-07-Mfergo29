class Post < ApplicationRecord
    belongs_to :user
    has_many :post_tags
    has_many :tags, through: :post_tags
    belongs_to :parent_post, class_name: 'Post', optional: true
    validates :title, :content, :user_id, presence: true
    validates :answers_count, :likes_count, numericality: { greater_than_or_equal_to: 0 }
  end
  