class User
  include Mongoid::Document
  include Mongoid::Enum
  include Mongoid::Slug
  include Mongo::Voter
  include Mongoid::Paranoia
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  devise :omniauthable, omniauth_providers: [:facebook]

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time


  ## Database Fields
  field :first_name,              type: String, default: ""
  field :last_name,               type: String, default: ""
  field :user_name,               type: String, default: ""
  field :work_place,              type: String, default: ""
  field :dob,                     type: Date
  enum :gender, [:female, :male]
  enum :occupation, [:Student, :Employee, :Other]
  field :avatar
  mount_uploader :avatar,  AvatarUploader

  # Slug + Scope

  slug :user_name, scope: where(deleted_at: nil)

  field :provider
  field :uid

  # Relations
  has_and_belongs_to_many :courses
  has_many :notes
  has_many :complaints
  has_many :questions
  has_many :answers
  has_many :votes

  # Validations
  validates_presence_of :first_name, :last_name, :user_name
  validates :user_name, uniqueness: true
  # Functions
  def name
    return "#{self.first_name} #{self.last_name}"
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.user_name = "#{auth.info.name}_#{auth.uid}"
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name   # assuming the user model has a name
      user.last_name = auth.info.last_name   # assuming the user model has a name
      user.avatar = auth.info.image.gsub('http://','https://') # assuming the user model has an image
      user.dob = auth.info.birthday # assuming the user model has an image
      user.gender = auth.extra.gender # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
