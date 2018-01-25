class Micropost < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.length_content}
  validate :picture_size

  scope :desc, ->{order created_at: :desc}

  mount_uploader :picture, PictureUploader

  private

  def picture_size
    sizes = Settings.megabytes
    return errors.add :picture, t("less_5mb") if picture.size > sizes.megabytes
  end
end
