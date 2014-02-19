class ServerInfo

  attr_accessor :server, :server_connection

  def initialize(server)
    @server            = server
    @server_connection = condenser(@server.host, @server.port)
  end

  def server_name
    server_name = status.fetch(:server_name,        'unknown')
    name = ActiveSupport::Multibyte::Chars.new(server_name).tidy_bytes
    server.update_attribute(:last_server_name, name)
    name
  end

  def number_of_players
    number_of_players = status.fetch(:number_of_players,  '0')
    server.update_attribute(:last_number_of_players, number_of_players)
    number_of_players
  end

  def max_players
    max_players = status.fetch(:max_players,        '0')
    server.update_attribute(:last_max_players, max_players)
    max_players
  end

  def map_name
    status.fetch(:map_name,           'unknown')
  end

  def status
    begin
      Rails.cache.fetch "status_#{server.id}" do
        if server_connection
          server_connection.server_info.delete_if {|key| key == :content_data }
        else
          {}
        end
      end
    rescue
      {}
    end
  end

  def condenser(host, port)
    begin
      SteamCondenser::Servers::SourceServer.new(@server.host, @server.port.to_i)
    rescue SocketError
    end
  end

end
