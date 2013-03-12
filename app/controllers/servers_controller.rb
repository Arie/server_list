class ServersController < ApplicationController

  skip_before_filter :authenticate_user!, :only => :index
  before_filter :require_admin, :only => [:new, :create, :edit, :update, :destroy]

  def new
    @server ||= Server.new
  end

  def create
    @server = Server.new(params[:server])
    if @server.save
      flash[:notice] = "Server added"
      redirect_to root_path
    else
      render :new
    end
  end

  def index
    load_server_info
    @categories = Category.ordered
  end

  def edit
    @server ||= Server.find(params[:id])
  end

  def update
    @server ||= Server.find(params[:id])
    if @server.update_attributes(params[:server])
      flash[:notice] = "Server updated"
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if Server.find(params[:id]).destroy
      flash[:notice] = "Server removed"
    end
    redirect_to root_path
  end

  private

  def load_server_info
    threads = []
    Server.all.each do |server|
      threads << Thread.new { server.status }
    end
    threads.each do |thread|
      thread.join(1)
    end
  end

  def require_admin
    if current_user && !current_user.admin?
      flash[:notice] = "You need to be an admin to do this"
      redirect_to root_path
    end
  end

end
