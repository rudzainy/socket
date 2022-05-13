require 'socket'

ADDRESS = '0.0.0.0'
PORT = 3000

class Server
  def initialize(socket_address, socket_port)

    print "| #{Time.now.ctime} | Starting the server."
    
    @server_socket = TCPServer.open(PORT)
    print "."

    @connections_details = Hash.new
    @connected_clients = Hash.new

    @connections_details[:server] = @server_socket
    @connections_details[:clients] = @connected_clients

    puts ". done!\n\nListening on port #{PORT}. Press CTRL+C to cancel... "
    run
  end

  def handle_connection(client_connection)
    puts "| #{Time.now.ctime} | New client socket connected at #{client_connection}"

    # client_connection.print
    client_connection.puts("| #{Time.now.ctime} | This is a message from the server. ")
    client_connection.puts("1. ")
    client_connection.puts("2. ")
    client_connection.puts("3. ")

    client_username = client_connection.gets.chomp.to_sym
    puts "Connection established #{client_username} => #{client_connection}"

    # case client_username
    #   when 1 then client_connection.puts("| #{Time.now.ctime} | client_name = #{client_name} ")
    #   when 3 then 
    #   else puts "Selection error"
    # end
    
# client_connection.puts("| #{Time.now.ctime} | Closing the connection with #{client_connection}. ")
#       puts("| #{Time.now.ctime} | Closing the connection with #{client_connection} ")
#       client_connection.close
    
    establish_chatting(client_username, client_connection)


  end

  def establish_chatting(username, connection)
    loop do
      message = connection.gets.chomp
      puts @connections_details[:clients]
      (@connections_details[:clients]).keys.each do |client|
        @connections_details[:clients][client].puts "#{username} : #{message}"
      end
    end
  end
  
  def run
    loop {
      new_client_connection = @server_socket.accept
      
      # Thread.start { handle_connection(new_client_connection) }
      Thread.start(new_client_connection) do |client_connection|
        client_username = client_connection.gets.chomp.to_sym

        if(@connections_details[:clients][client_username] != nil)
          client_connection.puts "This username is already taken"
          client_connection.puts "quit"
          client_connection.kill self
        end

        puts "Connection established #{client_username} => #{client_connection}" 
        @connections_details[:clients][client_username] = client_connection
        client_connection.puts "Connected to server as #{client_username}. You may continue chatting"

        establish_chatting(client_username, client_connection)
      end
    }.join
  end

  def close
    server.close
  end
end

Server.new(ADDRESS, PORT)

=begin
TODO
[x] convert server featurea to class
[x] test to make sure everything still works
[x] read: Thread.new vs Thread.start | https://www.geeksforgeeks.org/ruby-thread-class/#:~:text=%23%3CThread%3A0xbf04f18%3E-,new,-%3A%20This%20method%20is
[ ] refactor frontend
    
=end 