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

#define PORT 1234   

int main()
{
    struct sockaddr_in serveraddr, clientaddr;

    int s, i, clen = sizeof(clientaddr), nr, nr2;
    char buf[512],buf2[512],tr[512];

    s = socket(AF_INET, SOCK_DGRAM, 0);

    memset((char*)&serveraddr, 0, sizeof(serveraddr));
    serveraddr.sin_family = AF_INET;
    serveraddr.sin_port = htons(PORT);
    serveraddr.sin_addr.s_addr = htonl(INADDR_ANY);

    bind(s, (struct sockaddr*)&serveraddr, sizeof(serveraddr));

    while (1)
    {
        printf("Waiting for data...\n");
        memset(&buf, 0, sizeof(buf));
        recvfrom(s, &buf, sizeof(buf), 0, (struct sockaddr*)&clientaddr, &clen);
        nr = atoi(buf);
        printf("Received packet from %s:%d\n", inet_ntoa(clientaddr.sin_addr), ntohs(clientaddr.sin_port));
        printf("Data: %d\n", nr);

        printf("Waiting for data...\n");
        memset(&buf2, 0, sizeof(buf2));
        recvfrom(s, &buf2, sizeof(buf2), 0, (struct sockaddr*)&clientaddr, &clen);
        nr2 = atoi(buf2);
        printf("Received packet from %s:%d\n", inet_ntoa(clientaddr.sin_addr), ntohs(clientaddr.sin_port));
        printf("Data: %d\n", nr2);

        int suma = nr + nr2;
        //itoa(suma, tr, 10);
        sprintf(tr, "%d", suma);
        sendto(s, &tr, strlen(tr) * sizeof(char), 0, (struct sockaddr*)&clientaddr, clen);

    }

    close(s);
    return 0;
}