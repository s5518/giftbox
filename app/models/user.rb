class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_posts, through: :bookmarks, source: :post
  has_many :comments, dependent: :destroy

  validates :name, presence: true

  has_one_attached :profile_image

  def self.search_for(content)
    return all if content.blank?

    where("name LIKE ?", "%#{content}%")
  end


  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
      user.email = "guest@example.com"
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end
end
