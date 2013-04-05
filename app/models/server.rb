class Server < ActiveRecord::Base
  include OrderedByName

  attr_accessible :name, :host_and_port, :host, :port, :category_ids, :property_ids, :location_id, :last_server_name, :last_number_of_players, :last_max_players

  validates_presence_of :name, :host_and_port, :location_id
  validates_length_of :categories, :minimum => 1, :message => "need at least 1 category"
  validates_uniqueness_of :host, :scope => :port
  validate :validate_server_responds, :on => :create

  has_many :categories, :through => :server_categories
  has_many :server_categories

  has_many :properties, :through => :server_properties
  has_many :server_properties

  belongs_to :location

  delegate :map_name, :number_of_players, :max_players, :server_name, :status, :to => :server_info, :prefix => false
  delegate :name, :flag, :to => :location, :prefix => true, :allow_nil => true

  def server_connect_url
    steam_connect_url(host, port)
  end

  def host_and_port
    if host && port
      "#{host}:#{port}"
    end
  end

  def host_and_port=(host_and_port)
    if host_and_port && host_and_port.include?(":")
      self[:host] = host_and_port.split(":").first
      self[:port] = host_and_port.split(":").last
    else
      self[:host] = host_and_port
      self[:port] = '27015'
    end
  end

  def self.for_feed
    joins(:categories).where('categories.id IN (?)', Category.for_feed).
      order('last_number_of_players DESC').readonly(false)
  end

  private

  def steam_connect_url(host, port)
    "steam://connect/#{host}:#{port}"
  end

  def server_info
    @server_info ||= ServerInfo.new(self)
  end

  def validate_server_responds
    if server_name == 'unknown'
      errors.add(:host_and_port, "server is not responding")
    end
  end

end
