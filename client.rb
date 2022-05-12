require 'socket'

HOST = 'localhost'
PORT = 3000

print "Connecting to server.."
server_socket = TCPSocket.open(HOST, PORT)
puts ". Done!"

while message = server_socket.gets
    puts message.chomp
end

puts "Closing the connection..."

server_socket.close
