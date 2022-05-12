require 'socket'

PORT = 3000

def handle_connection(client_connection)
    puts "New client socket connected at #{client_connection}"

    client_connection.puts("This is a message from the server. ")
    client_connection.puts("Done sending data to client. ")
    client_connection.puts("Closing the connection with #{client_connection}. ")
    client_connection.close


    puts("Closing the connection with #{client_connection} ")
end

print "Starting the server."

server = TCPServer.open(PORT)
print "."

puts ". done!\n\nListening on port #{PORT}. Press CTRL+C to cancel... "

loop do
    new_client_connection = server.accept

    Thread.new { handle_connection(new_client_connection) }
end

server.close
