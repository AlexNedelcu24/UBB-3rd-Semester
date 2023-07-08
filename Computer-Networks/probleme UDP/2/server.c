#include <stdio.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <unistd.h>

int esteEchilibrat(int nr){
        int s_par=0, s_impar=0;
        int d = 1; // flag care imi tine paritatea
        while(nr != 0){
                if(d == 0) s_par += nr%10;
                if(d == 1) s_impar += nr%10;
                d = 1-d;
                nr = nr/10;
        }
        if(s_par == s_impar)
                return 1;
        return 0;
}

int solveClient(int n){
        int nr = n+1;
        while(1){
                if(esteEchilibrat(nr) == 1)
                        break;
                nr++;
        }
        return nr;
}

int main(){
        struct sockaddr_in serverAddr, clientAddr;
        socklen_t slen = sizeof(serverAddr), clen = sizeof(clientAddr);
        serverAddr.sin_family = AF_INET;
        serverAddr.sin_port = htons(1234);
        //serverAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
        serverAddr.sin_addr.s_addr = htonl(INADDR_ANY);

        int sock = socket(AF_INET, SOCK_DGRAM, 0);

        bind(sock, (struct sockaddr*)&serverAddr, slen);

        int nr;
        while(1){
                recvfrom(sock, &nr, sizeof(nr), 0, (struct sockaddr*)&clientAddr, &clen);
                nr = ntohl(nr);
                printf("Server received %d from %s:\n", nr, inet_ntoa(clientAddr.sin_addr));
                int res = solveClient(nr);
                printf("Urmatorul nr echilibat este: %d\n", res);
                res = htonl(res);
                sendto(sock, &res, sizeof(res), 0, (struct sockaddr*)&clientAddr, clen);
        }
}