class User < ApplicationRecord
  has_many :tweets

  validates :provider, presence: true
  validates :uid, presence: true
  validates :image_url, presence: true
  validates :token, presence: true
  validates :secret, presence: true

  def self.find_or_create_from_auth_hash(auth_hash)

    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    image_url = auth_hash[:info][:image]
    token = auth_hash[:credentials][:token]
    secret = auth_hash[:credentials][:secret]

    User.find_or_create_by(provider: provider, uid: uid) do |user|
      user.image_url = image_url
      user.token = token
      user.secret = secret
    end
  end
end
