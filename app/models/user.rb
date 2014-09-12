class User
  include Mongoid::Document
  include Mongoid::Enum
  include Mongoid::Slug
  include Mongo::Voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

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
  field :avatar
  mount_uploader :avatar,  AvatarUploader

  slug :user_name

  # Relations
  has_and_belongs_to_many :course
  has_many :notes
  has_many :complaints
  has_many :questions
  has_many :answers

  # Validations
  validates_presence_of :first_name, :last_name, :user_name
  validates :email, :user_name, uniqueness: true
  # Functions
  def name
    return "#{self.first_name} #{self.last_name}"
  end
end
