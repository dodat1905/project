class Profile < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: {maximum: Settings.name.maximum}
  validates :age, presence: true, numericality: {only_integer: true}
  validates :address, presence: true, length: {maximum: Settings.address.maximum}
end
