/* Enunt: Clientul trimite serverului un numar. Serverul il primeste si il afiseaza pe ecran.

Compilare:
    gcc server.c -o server
    gcc client.c -o client

Rulare in doua terminale diferite:
    ./server
    ./client
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <time.h>

#define SERVER "127.0.0.1"
#define PORT 1234

int main()
{
    struct sockaddr_in serveraddr, clientaddr;
    int s, i, slen = sizeof(serveraddr), clen = sizeof(clientaddr), nr;
    char buf[512],b[512];

    s = socket(AF_INET, SOCK_DGRAM, 0);

    memset((char*)&serveraddr, 0, sizeof(serveraddr));
    serveraddr.sin_family = AF_INET;
    serveraddr.sin_port = htons(PORT);
    serveraddr.sin_addr.s_addr = inet_addr(SERVER);

    printf("Trimiteti numarul : ");
    scanf("%s", &buf);
    sendto(s, &buf, strlen(buf)*sizeof(char), 0, (struct sockaddr*)&serveraddr, slen);

    printf("Trimiteti numarul : ");
    scanf("%s", &buf);
    sendto(s, &buf, strlen(buf)*sizeof(char), 0, (struct sockaddr*)&serveraddr, slen);

    printf("Waiting for data...\n");
    recvfrom(s, &b, sizeof(b), 0, (struct sockaddr*)&clientaddr, &clen);
    int nr2 = atoi(b);
    printf("Received packet from %s:%d\n", inet_ntoa(serveraddr.sin_addr), ntohs(serveraddr.sin_port));
    printf("Data: %d\n", nr2);

    close(s);
    return 0;
}