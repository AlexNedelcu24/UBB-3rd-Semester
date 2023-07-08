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

int main(int argc, char* argv[]) {
    struct sockaddr_in serveraddr, fromaddr;
    socklen_t slen = sizeof(serveraddr), flen = sizeof(fromaddr);
    

    char s[51], prim[51];
    int l, i, sock;
    while (1) {
        sock = socket(AF_INET, SOCK_DGRAM, 0);

        memset(&serveraddr, 0, sizeof(serveraddr));
        serveraddr.sin_family = AF_INET;
        serveraddr.sin_port = htons(atoi(argv[2]));
        serveraddr.sin_addr.s_addr = htonl(INADDR_ANY);

        bind(sock, (struct sockaddr*)&serveraddr, sizeof(serveraddr));

        int suma = 0;
        recvfrom(sock, &l, sizeof(l), 0, (struct sockaddr*)&fromaddr, &flen);
        
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

        int port = 4000 + s[strlen(s)+1];
        
        char msg[51];
        close(sock);
        sock = socket(AF_INET, SOCK_DGRAM, 0);
        memset(&serveraddr, 0, sizeof(serveraddr));
        serveraddr.sin_family = AF_INET;
        serveraddr.sin_port = htons(port);
        serveraddr.sin_addr.s_addr = htonl(INADDR_ANY);
        bind(sock, (struct sockaddr*)&serveraddr, sizeof(serveraddr));
        memset(&msg, 0, sizeof(msg));
        recvfrom(sock, &msg, sizeof(msg), 0, (struct sockaddr*)&fromaddr, &flen);
        printf("%s\n", msg);
        printf("Primit de la %s:%d\n", inet_ntoa(fromaddr.sin_addr), ntohs(fromaddr.sin_port));


        l = strlen(prim);
        printf("Suma trimisa: %d\n", suma);
        
        sendto(sock, &suma, sizeof(suma), 0, (struct sockaddr*)&fromaddr, flen);

        
        sendto(sock, &l, sizeof(l), 0, (struct sockaddr*)&fromaddr, flen);

        sendto(sock, &prim, strlen(prim) * sizeof(char), 0, (struct sockaddr*)&fromaddr, flen);
    }

    
}