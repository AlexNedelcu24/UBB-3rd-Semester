#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>


void deservire_client(int c) {

    int l;
    recv(c, &l, sizeof(int), MSG_WAITALL);
    l = ntohl(l); //lungime sir
    printf("Lungime = %i\n", l);

    char sir[100];
    recv(c, sir, l, MSG_WAITALL);
    printf("Sir primit: %s (%i)\n", sir, l); //sir    
    sir[l] = 0;
    char ch;
    recv(c, &ch, sizeof(char), MSG_WAITALL);
    printf("Caracter primit: %c\n", ch);//caracter

    int lrez = 0;
    for (int i = 0; i < l; i++) {
        if (sir[i] == ch)
            lrez++;
    }
    lrez = htonl(lrez);
    send(c, &lrez, sizeof(lrez), 0);

    int pozitii[100];
    int k = -1;
    for (int i = 0; i < l; i++) {
        if (sir[i] == ch) {
            k++;
            pozitii[k] = i;
        }
    }

    for (int i = 0; i < lrez; i++) {
        pozitii[i] = htonl(pozitii[i]);
        send(c, &pozitii[i], sizeof(pozitii[i]), 0);
    }
}


int main() {
    uint16_t valoare, rezultat;
    struct sockaddr_in server, client;
    int s = socket(AF_INET, SOCK_STREAM, 0);
    if (s < 0) {
        printf("Eroare la crearea socket-ului server!\n");
        return 1;
    }
    memset(&server, 0, sizeof(server));
    server.sin_port = htons(1235);
    server.sin_family = AF_INET;
    server.sin_addr.s_addr = INADDR_ANY; //orice adresa ip

    if (bind(s, (struct sockaddr*)&server, sizeof(server)) < 0) {
        printf("Eroare la bind\n");
        return 1;
    }

    listen(s, 5); //cati clienti ar trebui sa tina serverul in coada, carora nu le-a dat full accept
    int l = sizeof(client);
    memset(&client, 0, l);

    //SERVER ITERATIV - fara fork()
    //SERVER CONCURENT - cu fork()
    //while(1) //deserveste mai multi clienti
    //{		
    int c = accept(s, (struct sockaddr*)&client, &l);
    printf("S-a conectat clientul.\n");

    //if(fork()==0){ //fiu
    deservire_client(c);
    //exit(0);
//}
//}
    close(s);
}