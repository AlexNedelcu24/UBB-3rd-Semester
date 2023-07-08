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

int main(int argc, char* argv[])
{
    struct sockaddr_in serveraddr, clientaddr;
    int s, i, slen = sizeof(serveraddr), clen = sizeof(clientaddr), port;
    char sir[51], msg[51], ip[51], dif[51];

    s = socket(AF_INET, SOCK_DGRAM, 0);

    memset(&serveraddr, 0, sizeof(serveraddr));
    serveraddr.sin_family = AF_INET;
    serveraddr.sin_port = htons(8888);
    serveraddr.sin_addr.s_addr = inet_addr("127.0.0.1");


    printf("Trimiteti sirul: ");
    gets(sir);
    sendto(s, &sir, strlen(sir) * sizeof(char), 0, (struct sockaddr*)&serveraddr, slen);

    
    printf("Asteptare date\n");
    recvfrom(s, &port, sizeof(port), 0, (struct sockaddr*)&clientaddr, &clen);
    printf("Port primit: %d\n", port);
    printf("Primit de la %s:%d\n", inet_ntoa(clientaddr.sin_addr), ntohs(clientaddr.sin_port));

    sleep(5);
    close(s);
    s = socket(AF_INET, SOCK_DGRAM, 0);
    memset(&serveraddr, 0, sizeof(serveraddr));
    serveraddr.sin_family = AF_INET;
    serveraddr.sin_port = htons(port);
    serveraddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    strcpy(msg, "Client reconectat");
    sendto(s, &msg, strlen(msg) * sizeof(char), 0, (struct sockaddr*)&serveraddr, slen);


    printf("Asteptare date\n");
    recvfrom(s, &dif, sizeof(dif), 0, (struct sockaddr*)&clientaddr, &clen);
    printf("Sir %s\n", dif);
    printf("Primit de la %s:%d\n", inet_ntoa(clientaddr.sin_addr), ntohs(clientaddr.sin_port));

    printf("Asteptare date\n");
    recvfrom(s, &ip, sizeof(ip), 0, (struct sockaddr*)&clientaddr, &clen);
    printf("IP %s\n", ip);
    printf("Primit de la %s:%d\n", inet_ntoa(clientaddr.sin_addr), ntohs(clientaddr.sin_port));

    close(s);
}