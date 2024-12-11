class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  self.per_page = 10
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :image,
    content_type: {
      in: %w[image/jpeg image/gif image/png],
      message: "画像形式はjpeg, gif, pngのみ対応しています" },
    size: {
      less_than: 5.megabytes,
      message: "画像サイズは5MB以下にしてください" }
end
