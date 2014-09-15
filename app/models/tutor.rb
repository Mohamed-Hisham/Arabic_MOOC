class Tutor
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Enum
  include Mongo::Voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

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
  field :phone_number,            type: Integer
  field :dob,                     type: Date
  field :gender,                  type: String
  field :about_me
  field :interest
  enum :occupation, [:student, :lecturer, :employee, :other]
  field :avatar
  mount_uploader :avatar,  AvatarUploader

  slug :user_name
  rateable range: (1..5), raters: User



  # Relations
  has_many :notes
  has_many :courses
  has_many :answers

  # Validations
  validates_presence_of :first_name, :last_name, :user_name, :occupation
  validates :phone_number, format: { with: /\A(77|78|79)\d{7}\z/, message: "Only 77, 78, 79 then 7 digits" }, on: :update
  validates :email, :user_name, uniqueness: true


  #Functions
  def name
    return "#{self.first_name} #{self.last_name}"
  end

end
