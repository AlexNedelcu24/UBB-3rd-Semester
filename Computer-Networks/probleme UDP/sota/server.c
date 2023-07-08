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

    int s, i=1, clen = sizeof(clientaddr), suma, sume[101];
    char sir[51],ip[101][51],msg[51];

    srand(time(0));
    while (1)
    {   s = socket(AF_INET, SOCK_DGRAM, 0);

        memset(&serveraddr, 0, sizeof(serveraddr));
        serveraddr.sin_family = AF_INET;
        serveraddr.sin_port = htons(atoi(argv[2]));
        serveraddr.sin_addr.s_addr = htonl(INADDR_ANY);

        bind(s, (struct sockaddr*)&serveraddr, sizeof(serveraddr));



        printf("Asteptare date\n");
        memset(&sir, 0, sizeof(sir));
        recvfrom(s, &sir, sizeof(sir), 0, (struct sockaddr*)&clientaddr, &clen);
        printf("Primit de la %s:%d\n", inet_ntoa(clientaddr.sin_addr), ntohs(clientaddr.sin_port));
        
        char* p = strtok(sir, " ");
        suma = 0;
        while (p) {
            suma += atoi(p);
            p = strtok(NULL, " ");
        }

        
        int ran = (rand() % (9999 - 1111 + 1)) + 1111;
        printf("Portul trimis:%d\n", ran);
        sendto(s, &ran, sizeof(ran), 0, (struct sockaddr*)&clientaddr, clen);
        
        sume[i] = suma;
        strcpy(ip[i], inet_ntoa(clientaddr.sin_addr));

        close(s);
        s = socket(AF_INET, SOCK_DGRAM, 0);
        memset(&serveraddr, 0, sizeof(serveraddr));
        serveraddr.sin_family = AF_INET;
        serveraddr.sin_port = htons(ran);
        serveraddr.sin_addr.s_addr = htonl(INADDR_ANY);
        bind(s, (struct sockaddr*)&serveraddr, sizeof(serveraddr));
        memset(&msg, 0, sizeof(msg));
        recvfrom(s, &msg, sizeof(msg), 0, (struct sockaddr*)&clientaddr, &clen);
        printf("%s\n", msg);
        printf("Primit de la %s:%d\n", inet_ntoa(clientaddr.sin_addr), ntohs(clientaddr.sin_port));
        
        
        if (i == 1) {
            sendto(s, &sume[1], sizeof(sume[1]), 0, (struct sockaddr*)&clientaddr, clen);
            printf("Suma trimisa este %d\n", suma);

            sendto(s, &ip[1], sizeof(ip[1]), 0, (struct sockaddr*)&clientaddr, clen);
            printf("IP trimis %s\n", ip[1]);

        }
        else {
            sendto(s, &sume[i-1], sizeof(sume[i-1]), 0, (struct sockaddr*)&clientaddr, clen);
            printf("Suma trimisa este %d\n", sume[i-1]);

            sendto(s, &ip[i-1], sizeof(ip[i-1]), 0, (struct sockaddr*)&clientaddr, clen);
            printf("IP trimis %s\n", ip[i-1]);
        }

        i++;
        printf("\n\n");
    }

    close(s);
    return(0);
}