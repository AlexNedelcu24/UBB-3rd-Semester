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

int main() {
    struct sockaddr_in serverAddr, fromaddr;
    socklen_t slen = sizeof(serverAddr), flen = sizeof(fromaddr);
    serverAddr.sin_family = AF_INET;
    serverAddr.sin_port = htons(8888);
    serverAddr.sin_addr.s_addr = htonl(INADDR_ANY);

    int sock = socket(AF_INET, SOCK_DGRAM, 0);

    bind(sock, (struct sockaddr*)&serverAddr, slen);

    char s[51],prim[51];
    int l,i;
    while (1) {
        int suma = 0;
        recvfrom(sock, &l, sizeof(l), 0, (struct sockaddr*)&fromaddr, &flen);
        l = ntohl(l);
        memset(&s, 0, sizeof(s));
        recvfrom(sock, &s, l, 0, (struct sockaddr*)&fromaddr, &flen);
        printf("Server received %s from %s:\n", s, inet_ntoa(fromaddr.sin_addr));
        
        for (i = 0; i < l; i++) {
            suma = suma + s[i];
        }

        int div = 0;
        for (i = 2; i < suma; i++) {
            if (suma % i == 0)
            {
                div = 1;
                break;
            }
        }

        memset(&prim, 0, sizeof(prim));
        if (div == 0) {
            strcpy(prim, "prim");
        }
        else {
            strcpy(prim, "neprim");
        }

        l = strlen(prim);
        printf("Suma trimisa: %d\n", suma);
        suma = htonl(suma);
        sendto(sock, &suma, sizeof(suma), 0, (struct sockaddr*)&fromaddr, flen);

        l = htonl(l);
        sendto(sock, &l, sizeof(l), 0, (struct sockaddr*)&fromaddr, flen);

        sendto(sock, &prim, strlen(prim) * sizeof(char), 0, (struct sockaddr*)&fromaddr, flen);
    }
}