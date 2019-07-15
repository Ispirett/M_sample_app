class Micropost < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: {maximum: 140}
  validates :user_id , presence: true

  mount_uploader :picture , PictureUploader
  validate :picture_size
  default_scope  -> {order(created_at: :desc)}
  private
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, 'Picture must be 5 of less megabytes')
    end
  end



end
