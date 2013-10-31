class User < ActiveRecord::Base

  # !**************************************************
  # !                Associations
  # !**************************************************

  # !**************************************************
  # !                Validations
  # !**************************************************

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

  # Override name to return email address if no name is set
  def name
    super.blank? ? self.email : super
  end

end
