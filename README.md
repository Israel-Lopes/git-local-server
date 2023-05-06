# Servidor git

Essa documentação tem como objetivo ensinar a criar seu proprio servidor pessoal git. Para isso,
basta fazer git push do projeto e seguir os passos descritos abaixo. 

Nosso servidor sera criado em uma imagem docker para ilustrar como seria feito 
em um servidor real, para com isso aprender os conhecimentos aqui vistos e 
aplicar em grande escala em um servidor real.

## Subindo imagem

Para criar imagem do servidor: ``sudo docker build -t git-server .``

Rodando imagem: ``sudo docker run -d -p 2222:22 --name git-container git-server:latest``
 
Para entrar: ``sudo docker exec -it git-container bash``

Adicionar repositorio: git remote add origin git@seu-servidor-git:/caminho/para/repositorio.git

## Configuração

No modo interativo do shell siga os seguintes passos:

1. Configuração do servidor SSH.
2. Criação de um repositório Git.
3. Criação de um usuário Git
4. Configuração das chaves SSH.
5. Configuração do acesso remoto.

### Configurando servidor SSH: 1#

Na imagem o servidor ssh ja esta sendo configurado, porem para fins didaticos irei explicar como
configuralo, para caso queiram fazer em uma maquina real.

Primeiro instale o cliente SSH: 

``sudo apt-get install openssh-server``

Caso o servidor SSH nao inicie automaticamente faça: 

``sudo service ssh start``

O servidor SSH estará ouvindo na porta 22 por padrão. 

Se você desejar alterar a porta, pode editar
o arquivo de configuração do servidor SSH. O arquivo de configuração geralmente 
está localizado em ``/etc/ssh/sshd_config``.

Agora você pode permitir que usuários específicos acessem o servidor Git via SSH. 

Para fazer isso
, adicione as chaves públicas dos usuários ao arquivo ``~/.ssh/authorized_keys`` do 
usuário "git" no servidor Git.

Agora reinicie o servidor SSH para as alteraçoes entrarem em vigor: ``sudo service ssh restart``

### Criando o repositorio do projeto: 2#

Crie o diretorio na home, nome do projeto e de sua escolha, porem aqui irei por de ``~/gitrep``.

Para isso basta fazer: ``mkdir ~/gitrep``

Agora alterne para o usuário Git usando o comando: ``su - <nome-do-usuario>``

Quando você executa o comando ``su - <nome-do-usuario>``, você está efetuando o login como o usuário e assumindo sua identidade. Isso é necessário para executar comandos como o usuário e realizar operações relacionadas ao Git.

Agora navegue ate o diretorio do projeto: ``cd /gitrepo``

Basta agora incializar um novo projeto:

``git init --bare <nome-do-repositorio>.git``

Agora com repositorio criado, você podera clonalo. Basta fazer:

``git clone git@<seu-servidor-git>:/caminho/para/repositorio.git``

### Configurando usuario GIT: 3#

O comando a seguir cria um usuario git

``adduser --shell /bin/bash <nome-do-usuario>``

Com isso sera criado um usuario git chamado pedro.

Agora temos que definir uma senha:

``passwd <senha-do-usuario>``

Agora você precisa gerar um par de chaves SSH para o usuário Git. Essas chaves serão usadas para autenticação ao acessar o servidor Git remotamente. Ainda dentro do shell do servidor Git, execute o seguinte comando como usuário "git":

``su - git``

``ssh-keygen -t rsa``

Isso irá gerar uma chave SSH pública e privada para o usuário Git. 
Quando solicitado, você pode pressionar Enter para aceitar o local padrão e não definir uma senha para a chave.

Para permitir que o usuário Git tenha acesso ao diretório de repositórios, certifique-se de que o diretório /gitrepo (ou o diretório onde você pretende armazenar os repositórios) tenha as permissões corretas. Dentro do shell do servidor Git, execute o seguinte comando:

``chown -R git:git /gitrepo``

### Configuração das chaves SSH: 4#



### Configuração do acesso remoto #5