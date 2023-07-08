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
    int s, i, slen = sizeof(serveraddr), flen = sizeof(fromaddr), port;
    char sir[51];

    s = socket(AF_INET, SOCK_DGRAM, 0);

    memset(&serveraddr, 0, sizeof(serveraddr));
    serveraddr.sin_family = AF_INET;
    serveraddr.sin_port = htons(atoi(argv[2]));
    serveraddr.sin_addr.s_addr = inet_addr(argv[1]);


    for (i = 0; i <= 1000; i++) {
        sendto(s, &i, sizeof(i), 0, (struct sockaddr*)&serveraddr, slen);
        sleep(0.01);
    }


    close(s);
}