class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    User.attr_accessible :time_zone
    if current_user.update_attributes(params[:user])
      flash[:notice] = "Settings saved"
    end
    redirect_to root_path
  end

end
