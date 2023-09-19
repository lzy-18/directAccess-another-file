#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<unistd.h>
#include<arpa/inet.h>
#include<sys/socket.h>

int client(char *ipaddr){
	// char *ipaddr = (char *)arg;
	//创建套接字
	int sock = socket(AF_INET, SOCK_STREAM, 0);

	//服务器的ip为本地，端口号1234
	struct sockaddr_in serv_addr;
	memset(&serv_addr, 0, sizeof(serv_addr));
	serv_addr.sin_family = AF_INET;
	serv_addr.sin_addr.s_addr = inet_addr(ipaddr);
	serv_addr.sin_port = htons(1234);
	
	//向服务器发送连接请求
	connect(sock, (struct sockaddr*)&serv_addr, sizeof(serv_addr));
	long ret=0;

  char buf[256]="hello world!";
	ret = write(sock, buf, sizeof(buf));
	
  char buf2[256]="alloha!!!";
	ret = write(sock, buf2, sizeof(buf2));

	char data[256];
  ret = read(sock, (char *)data, sizeof(data));
	printf("client-data:%s\n",data);
	
	//断开连接
	close(sock);

	return (int)ret;
}

int main(){
  client("172.25.69.108");
  return 0;
}