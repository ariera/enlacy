class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :rememberable, :trackable,
    :lockable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :password, :password_confirmation, :remember_me, :login
  
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  # attr_accessor :login
  # attr_accessible :login

  has_many :links
  has_many :main_links, :class_name=>"Link", :conditions=>{:working=>false}, :order => "position"
  has_many :working_links, :class_name=>"Link", :conditions=>{:working=>true}, :order => "position"

  def to_param
    login
  end
  
  protected
  
  def email_required?
    false
  end
  # def self.find_for_database_authentication(warden_conditions)
  #   conditions = warden_conditions.dup
  #   login = conditions.delete(:login)
  #   where(conditions).where(["username = :value OR email = :value", { :value => login }]).first
  # end

end
