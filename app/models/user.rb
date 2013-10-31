class User < ActiveRecord::Base

  # !**************************************************
  # !                Associations
  # !**************************************************

  # !**************************************************
  # !                Validations
  # !**************************************************
  validates_presence_of :name

  # !**************************************************
  # !                Callbacks
  # !**************************************************

  # !**************************************************
  # !                  Other
  # !**************************************************
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include Filterable

  def is_admin?
    self.admin
  end
end
