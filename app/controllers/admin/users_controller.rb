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
      redirect_to admin_user_path(@user), notice: "User created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user), notice: "#{@user.name} updated"
    else
      render :edit
    end
  end

  def destroy
    redirect_to admin_users_path, alert: "You can't delete yourself" and return if current_user == @user
    if @user.delete
      flash[:notice] = "User #{@user.name} deleted"
      respond_to do |format|
        format.html { redirect_to admin_users_path }
        format.js
      end
    else
      redirect_to admin_user_path(@user), alert: "Could not delete user #{@user.name}"
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :admin)
    end
end
