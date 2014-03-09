class ServersController < ApplicationController

  skip_before_filter :authenticate_user!, :only => [:index, :feed, :show]
  before_filter :require_admin, :only => [:new, :create, :edit, :update, :destroy]
  caches_action :feed, :cache_path => Proc.new {|c| c.request.url }, :expires_in => 1.minute

  def new
    @server ||= Server.new
  end

  def show
    @server ||= find_server
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
    respond_to do |format|
      format.html { render :index }
      format.json { render :json => Server.all.to_json }
    end
  end

  def feed
    @title = "Server list"
    load_server_info(Server.for_feed)
    @servers = Server.for_feed

    # this will be our Feed's update timestamp
    @updated = Time.now

    respond_to do |format|
      format.atom { render :layout => false }

      # we want the RSS feed to redirect permanently to the ATOM feed
      format.rss { redirect_to feed_servers_path(:format => :atom), :status => :moved_permanently }
    end
  end

  def edit
    @server ||= find_server
  end

  def update
    @server ||= find_server
    if @server.update_attributes(params[:server])
      flash[:notice] = "Server updated"
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if find_server.destroy
      flash[:notice] = "Server removed"
    end
    redirect_to root_path
  end

  private

  def find_server
    @find_server ||= Server.find(params[:id].to_i)
  end

  def load_server_info(servers = Server.all)
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
