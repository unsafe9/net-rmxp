require 'socket'

# 서버에 연결
server = TCPSocket.new('localhost', 3000)

server.puts('Hello, server!')

# 서버로부터 메시지를 무한히 수신하여 출력
loop do
  message = server.gets.chomp
  puts "msg: #{message}"
end

# TCP 연결 종료
server.close
