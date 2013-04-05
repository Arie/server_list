atom_feed :language => 'en-US' do |feed|
  feed.title @title
  feed.updated @updated

  @servers.each do |server|
    feed.entry(server,
               :updated   => (Time.now + server.last_number_of_players.to_i.seconds),
               :published => (Time.now + server.last_number_of_players.to_i.seconds)
              ) do |entry|
      entry.url server.server_connect_url
      feed_name = "#{truncate(server.last_server_name, :length => 25)} (#{server.last_number_of_players}/#{server.last_max_players})"
      entry.title "#{h(feed_name)}"
      entry.content "#{server.categories.first.name}: #{server.last_server_name} (#{server.last_number_of_players}/#{server.last_max_players})"

      entry.author do |author|
        author.name "Arie"
      end
    end
  end
end
