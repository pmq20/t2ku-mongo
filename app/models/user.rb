# -*- encoding : utf-8 -*-
class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongo::Voter
  include Redis::Search
  include BaseModel
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  # ================================= 【Attr】 ===============================================
  
  ## Database authenticatable
  field :email,              :type => String, :null => false, :default => ""
  field :encrypted_password, :type => String, :null => false, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Encryptable
  # field :password_salt, :type => String

  ## Confirmable
  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  field :name
  field :slug
  field :location
  field :website
  field :signature
  # ================================= 【AttrBehavior】 ============================================
  # -------------------- 1.guard -------------------------------

  # ------------------- 2.relationship -------------------------
  has_many :tasks
  has_and_belongs_to_many :books
  # ------------------- 3、validations --------------------------
  validates :name, :presence => true
  validates_length_of :name,:within=>3..20
  validates_length_of :website,:maximum=>80
  validates_length_of :location,:maximum=>80
  validates_length_of :signature,:maximum=>90
  # ------------------------------------------------------------
  # ================================= 【Instance】 =============================================
  def basic_attributes
    ret = {}
    ret[:id]=self.id
    ret[:name]=self.name
    ret[:email]=self.email
    ret[:no_validation]=true
    ret
  end
  # ================================= 【Hookers】 ==============================================
  # ================================= 【Class】 ==========================================

end
