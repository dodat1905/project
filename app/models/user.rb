class User < ApplicationRecord
  attr_reader :remember_token, :activation_token, :reset_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  has_many :microposts, dependent: :destroy
  has_many :active_relationships, inverse_of: :follower, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, inverse_of: :followed, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_one :profile, dependent: :destroy

  accepts_nested_attributes_for :profile

  validates :email, format: {with: VALID_EMAIL_REGEX},
    presence: true, uniqueness: {case_sensitive: false}, length: {maximum: Settings.email.maximum}
  validates :password, presence: true, length: {minimum: Settings.password.minimum}, allow_nil: true

  before_save :emaildowncase
  before_create :create_activation_digest

  scope :activated, ->{where activated: true}

  has_secure_password

  class << self
    def digest string
      cost =
        if ActiveModel::SecurePassword.min_cost
          BCrypt::Engine::MIN_COST
        else
          BCrypt::Engine.cost
        end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    @remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest
    BCrypt::Password.new(digest).is_password? token
  end

  def current_user? current_user
    self == current_user
  end

  def activate
    update_attributes activated: true, activated_at: Time.zone.now
  end

  def create_reset_digest
    @reset_token = User.new_token
    update_attributes reset_digest: User.digest(reset_token),
      reset_sent_at: Time.zone.now
  end

  def password_reset_expired?
    expired = Settings.hours_ago
    reset_sent_at < expired.hours.ago
  end

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  def feed
    Micropost.following_ids self
  end

  private

  def emaildowncase
    email.downcase!
  end

  def create_activation_digest
    @activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
