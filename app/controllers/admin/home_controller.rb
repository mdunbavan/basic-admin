class Admin::HomeController < AdminController
  def index
    authorize! :admin, :index
  end
end