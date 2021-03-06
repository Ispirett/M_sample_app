class User < ApplicationRecord
  attr_accessor :remember_token , :activation_token
  before_save :downcase_email
  before_create :create_activation_digest # create activation token before user is created
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name , presence: true, length: {maximum: 51}
  validates :email, presence: true, length: {maximum: 255} ,
                         format: {with: VALID_EMAIL_REGEX},
                         uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password , presence:true , length:{minimum: 6}, allow_nil: true



   def downcase_email
   self .email.downcase!
   end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true iff the five token matches digest
  def authenticated?(attribute,token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_token, nil)
  end

  self.per_page = 10


  # account activation
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # activation token
  private
  def create_activation_digest
     self.activation_token  =  User.new_token
     self.activation_digest = User.digest(activation_token)

   end
end
