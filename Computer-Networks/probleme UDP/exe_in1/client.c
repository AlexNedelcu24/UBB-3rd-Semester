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
    struct sockaddr_in serveraddr, fromaddr;
    int s, i, slen = sizeof(serveraddr), flen = sizeof(fromaddr), l, suma;
    char sir[51], prim[51], msg[51];

    s = socket(AF_INET, SOCK_DGRAM, 0);

    memset(&serveraddr, 0, sizeof(serveraddr));
    serveraddr.sin_family = AF_INET;
    serveraddr.sin_port = htons(atoi(argv[2]));
    serveraddr.sin_addr.s_addr = inet_addr(argv[1]);


    printf("Trimiteti sirul: ");
    gets(sir);
    l = strlen(sir);
    sendto(s, &l, sizeof(l), 0, (struct sockaddr*)&serveraddr, slen);
    sendto(s, &sir, l, 0, (struct sockaddr*)&serveraddr, slen);

    int port = 4000 + sir[strlen(sir) - 1];
    sleep(2);
    close(s);
    s = socket(AF_INET, SOCK_DGRAM, 0);
    memset(&serveraddr, 0, sizeof(serveraddr));
    serveraddr.sin_family = AF_INET;
    serveraddr.sin_port = htons(port);
    serveraddr.sin_addr.s_addr = inet_addr(argv[1]);
    strcpy(msg, "Port schimbat!");
    sendto(s, &msg, strlen(msg) * sizeof(char), 0, (struct sockaddr*)&serveraddr, slen);


    recvfrom(s, &suma, sizeof(suma), 0, (struct sockaddr*)&fromaddr, &flen);
    printf("Suma %d\n", suma);
    printf("Primit de la %s:%d\n", inet_ntoa(fromaddr.sin_addr), ntohs(fromaddr.sin_port));

    int len;
    recvfrom(s, &len, sizeof(len), 0, (struct sockaddr*)&fromaddr, &flen);
    printf("Lungimea %d\n", len);
    printf("Primit de la %s:%d\n", inet_ntoa(fromaddr.sin_addr), ntohs(fromaddr.sin_port));

    recvfrom(s, &prim, len, 0, (struct sockaddr*)&fromaddr, &flen);
    printf("Suma este nr %s\n", prim);
    printf("Primit de la %s:%d\n", inet_ntoa(fromaddr.sin_addr), ntohs(fromaddr.sin_port));

    close(s);
}
