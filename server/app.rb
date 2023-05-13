require 'socket'

class Server
  def initialize(port)
    @server = TCPServer.new(port)
    @clients = {}
    @client_id = 0
  end

  def start
    loop do
      # Wait for new I/O events
      readables, _, _ = IO.select([@server] + @clients.values)

      # Handle new clients
      readables.each do |socket|
        if socket == @server
          client = @server.accept
          @client_id += 1
          @clients[@client_id] = client
          puts "Client #{@client_id} connected"
          client.puts(@client_id)
        else
          handle_client(socket)
        end
      end
    end
  end

  private

  def handle_client(client)
    client_id = @clients.key(client)
    begin
      request = client.gets.chomp
      puts "Client #{client_id} sent: #{request}"
      # process the request
      response = "Hello, #{request}!"
      client.puts(response)
    rescue
      puts "Client #{client_id} disconnected"
      @clients.delete(client_id)
      client.close
    end
  end
end

server = Server.new(3000)
server.start
