import socket
import struct


c = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
c.connect(("127.0.0.1", 1235))

sir = raw_input("Dati sirul: ")
l = len(sir)
c.send(struct.pack('!i', l))
c.send(sir.encode('ascii'))  

ch = raw_input("Dati caracterul: ")
print(ch.encode())
c.send(ch.encode()) 

lrez = c.recv(4)
lrez = struct.unpack('!i', lrez)[0]

rez = []
for i in range(lrez):
    el = c.recv(4)
    el = struct.unpack('!i', el)[0]
    rez.append(el)

print("Lungime rezultat:")
print("Pozitiile sunt:")
c.close()