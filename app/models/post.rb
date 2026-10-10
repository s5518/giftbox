class Post < ApplicationRecord
  belongs_to :user

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :gift_name, presence: true
  validates :content, presence: true
  validates :age, presence: true
  validates :price, presence: true

  has_one_attached :image

  def self.search_for(content)
    return all if content.blank?

    where(
      "gift_name LIKE :keyword OR content LIKE :keyword",
      keyword: "%#{content}%"
    )
  end
end
