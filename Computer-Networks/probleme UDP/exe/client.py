import socket
import struct

IP = '127.0.0.1'
PORT = 8888
server = (IP, PORT)

client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)


s = raw_input("Dati sirul: ")       
l = len(s)
l = l+1
client.sendto(struct.pack('!i', l), server)
client.sendto(s.encode('ascii'), server)

res, addr = client.recvfrom(4)
r = struct.unpack('!i', res)
r = r[0]
print("Suma este:" + str(r) + "!")

res, addr = client.recvfrom(4)
r = struct.unpack('!i', res)
r = int(r[0])
print("Lungimea este:" + str(r) + "!")


re, addr = client.recvfrom(r)
re = re.decode('ascii')
print("Suma este nr: " + str(re) + "!")

client.close()