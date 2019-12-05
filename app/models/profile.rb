class Profile < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: {maximum: 50}
  validates :age, presence: true, numericality: {only_integer: true}
  validates :address, presence: true, length: {maximum: 50}
end
