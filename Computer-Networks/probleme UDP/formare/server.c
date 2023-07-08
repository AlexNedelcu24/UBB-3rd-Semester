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

    int s, flen = sizeof(fromaddr), i;
    char sir[51];

    s = socket(AF_INET, SOCK_DGRAM, 0);

    memset(&serveraddr, 0, sizeof(serveraddr));
    serveraddr.sin_family = AF_INET;
    serveraddr.sin_port = htons(atoi(argv[2]));
    serveraddr.sin_addr.s_addr = htonl(INADDR_ANY);

    bind(s, (struct sockaddr*)&serveraddr, sizeof(serveraddr));

    srand(time(0));
    while (1)
    {
        for (i = 0; i <= 1000; i++) {
            int nr;
            printf("Asteptare date\n");
            recvfrom(s, &nr, sizeof(nr), 0, (struct sockaddr*)&fromaddr, &flen);
            printf("Numarul este %d\n", nr);
            printf("Primit de la %s:%d\n\n", inet_ntoa(fromaddr.sin_addr), ntohs(fromaddr.sin_port));
        }

        printf("\n\n\n");
    }

    close(s);
}