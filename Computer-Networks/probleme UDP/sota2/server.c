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

    int s, i = 1, clen = sizeof(clientaddr), port = 8888, nr=1, frecventa[200];
    char sir[51], msg[51], diferite[51], ant1[101][51], ant2[101][51];

    while (1)
    {
        s = socket(AF_INET, SOCK_DGRAM, 0);

        memset(&serveraddr, 0, sizeof(serveraddr));
        serveraddr.sin_family = AF_INET;
        serveraddr.sin_port = htons(8888);
        serveraddr.sin_addr.s_addr = htonl(INADDR_ANY);

        bind(s, (struct sockaddr*)&serveraddr, sizeof(serveraddr));

        printf("Asteptare date\n");
        memset(&sir, 0, sizeof(sir));
        recvfrom(s, &sir, sizeof(sir), 0, (struct sockaddr*)&clientaddr, &clen);
        printf("Sirul este: %s\n", sir);
        printf("Primit de la %s:%d\n", inet_ntoa(clientaddr.sin_addr), ntohs(clientaddr.sin_port));
        
        
        memset(&frecventa, 0, sizeof(frecventa));
        int i;
        for (i = 0; i < strlen(sir); i++) {
            if (sir[i] == ' ')
                port++;
            frecventa[sir[i]] = 1;
        }

        sendto(s, &port, sizeof(port), 0, (struct sockaddr*)&clientaddr, clen);
        printf("Port %d trimis\n", port);

        close(s);
        s = socket(AF_INET, SOCK_DGRAM, 0);
        memset(&serveraddr, 0, sizeof(serveraddr));
        serveraddr.sin_family = AF_INET;
        serveraddr.sin_port = htons(port);
        serveraddr.sin_addr.s_addr = htonl(INADDR_ANY);
        bind(s, (struct sockaddr*)&serveraddr, sizeof(serveraddr));
        printf("Asteptare date\n");
        memset(&msg, 0, sizeof(msg));
        recvfrom(s, &msg, sizeof(msg), 0, (struct sockaddr*)&clientaddr, &clen);
        printf("%s\n", msg);
        printf("Primit de la %s:%d\n", inet_ntoa(clientaddr.sin_addr), ntohs(clientaddr.sin_port));


        strcpy(diferite, "");
        for (i = 97; i <= 122; i++) {
            if (frecventa[i] == 1) {
                char a = i;
                strncat(diferite, &a, 1);
            }
                
        }

        strcpy(ant1[nr], diferite);
        strcpy(ant2[nr], inet_ntoa(clientaddr.sin_addr));

        if (nr == 1) {
            sendto(s, &ant1[1], sizeof(ant1[1]), 0, (struct sockaddr*)&clientaddr, clen);
            printf("Sir trimis: %s\n", ant1[1]);

            sendto(s, &ant2[1], sizeof(ant2[1]), 0, (struct sockaddr*)&clientaddr, clen);
            printf("Sir trimis: %s\n", ant2[1]);
        }
        else {
            sendto(s, &ant1[nr-1], sizeof(ant1[nr-1]), 0, (struct sockaddr*)&clientaddr, clen);
            printf("Sir trimis: %s\n", ant1[nr-1]);

            sendto(s, &ant2[nr-1], sizeof(ant2[nr-1]), 0, (struct sockaddr*)&clientaddr, clen);
            printf("IP trimis: %s\n", ant2[nr-1]);
        }

        nr++;
        printf("\n\n\n");
    }

    close(s);
    return(0);
}