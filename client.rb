require 'socket'

HOST = 'localhost'
PORT = 3000

class Client 
  def initialize(socket_host, socket_port)

    print "Connecting to server.."
    @server_socket = TCPSocket.open(socket_host, socket_port)
    puts ". Done!"

    @request_object = send_request
    @response_object = listen_response

    @request_object.join
    @response_object.join
    # while message = @server_socket.gets
    #     puts message.chomp
    # end

    # run
  end

  def send_request
    
    # handle usernames
    puts "Enter your username"
    print "> "
    begin
      Thread.new do
        loop do
          response = $stdin.gets.chomp
          @server_socket.puts response
        end
      end
    end

    # close
  end

  def listen_response
    begin
      Thread.new do
        loop do
          response = @server_socket.gets.chomp
          puts "#{response}"
        end
      end
    end
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