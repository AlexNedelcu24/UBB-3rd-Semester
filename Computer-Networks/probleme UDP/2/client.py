import socket
import struct

UDP_IP = '127.0.0.1'
UDP_PORT = 1234
server = (UDP_IP, UDP_PORT)

client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

while True:
        nr = int(raw_input("Introdu un numar: "))
        
        client.sendto(struct.pack('!i', nr), server)
        res, addr = client.recvfrom(4)
        
        r = struct.unpack('!i', res)
        r = r[0]
        print("Urmatorul numar echilibrat este:" + str(r) + "!")

client.close()