FROM ubuntu:latest

# Instalação do Git
RUN apt-get update && apt-get install -y git

# Instalação do servidor SSH
RUN apt-get install -y openssh-server

# Configuração do servidor SSH
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Criação do diretório para o repositório Git
RUN mkdir /gitrepo
WORKDIR /gitrepo
RUN git init --bare

# Exposição da porta 22 para SSH
EXPOSE 22

# Execução do servidor SSH
CMD ["/usr/sbin/sshd", "-D"]
