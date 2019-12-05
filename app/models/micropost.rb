class Micropost < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  validate :picture_size

  scope :desc, ->{order created_at: :desc}
  scope :following_ids, (lambda do |user|
    following_ids = "SELECT followed_id FROM relationships
      WHERE follower_id = :user_id"
    where "user_id IN (#{following_ids}) OR user_id = :user_id", user_id: user.id
  end)

  mount_uploader :picture, PictureUploader

  private

  def picture_size
    sizes = 100000
    return errors.add :picture, t("less_5mb") if picture.size > sizes.megabytes
  end
end
