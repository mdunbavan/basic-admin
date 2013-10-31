class AdminController < ApplicationController

  layout 'admin'

  before_filter :check_admin

  private

    def check_admin
      redirect_to :root unless current_user.is_admin?
    end

end
