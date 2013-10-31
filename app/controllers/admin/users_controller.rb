class Admin::UsersController < AdminController

  load_and_authorize_resource

  def index
    @users = User.filter(params)

    @columns = ["name", "email"]
    @filters = { "name" => nil, "email" => nil }

    respond_to do |format|
        format.html
        format.js
    end
  end

  def show
  end

  def new
  end

  def create
    @user = User.new(user_params)
    @user.password = Devise.friendly_token.first(20) if @user.password.blank?

    if @user.save
      redirect_to admin_user_path(@user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    if @user.delete
      redirect_to admin_users_path
    else
      redirect_to admin_user_path(@user)
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :admin)
    end
end
