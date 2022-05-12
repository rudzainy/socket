require 'socket'

HOST = 'localhost'
PORT = 3000

class Client 
  def initialize(socket_host, socket_port)

    print "Connecting to server.."
    @server_socket = TCPSocket.open(socket_host, socket_port)
    puts ". Done!"

    while message = @server_socket.gets
        puts message.chomp
    end

    run
  end

  def run
    
    # handle usernames
    puts "Enter your username"
    print "> "

    response = $stdin.gets.chomp
    @server_socket.puts response

    close
  end

  def close
    
    puts "Closing the connection..."
    
    @server_socket.close

  end
end

Client.new(HOST, PORT)

=begin
TODO
[ ] Chat

=end