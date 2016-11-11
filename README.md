# NovoSGA Docker

### Passos para instalação/funcionamento completo do docker para o novoSGA =====
#### Observações
* É interessante seguir a risca todos os passos apresentados a seguir para manter o funcionamento completo do processo. Caso queira mudar o link das pastas do novoSGA do host com o container, é necessário fazer alterações no docker-compose.yml (Linha 8) e nos comandos do passo 11, antes de executar o processo todo.
* Após os passos todos, existirá uma pasta chamada "novosga" clonada dentro de outra pasta chamada "novosgaDocker", é essa a sua ligação entre o Host e o Container. É nessa pasta, "novosga", que deverão ser feitas as mudanças e contribuições para o projeto. O Docker irá linkar automaticamente todas as mudanças feitas ali, para dentro do container.


##### Vamos aos passos para executar rodar os containers de desenvolvimento para o NovoSGA com o Docker
1- Instalar o [Docker](https://docs.docker.com/engine/getstarted/step_one/) no seu SO;  
2- Instalar o [Docker Compose](https://docs.docker.com/compose/install/), dependendo do SO, ele já vem instalado com a instalação do Docker;  
3- Clonar o repositório desse GitHub contendo o dockerfile e o docker-compose file;  
4- Clonar também o repositório do novoSGA no [GitHub](https://github.com/GCS-Projects/novosga) ou [GitHub Oficial](https://github.com/novosga/novosga), dentro da pasta do novosgaDocker clonado no item 3; 
5- Acessar via terminal a pasta do novosgaDocker;  
6- Executar o comando: `docker-compose up -d` (-d é uma tag para manter em segundo plano a execução dos container após a conclusão do "up");  


##### Agora é necessário fornecer permissões para a pasta do novoSGA copiada para dentro do container:
7- Executar o comando: `docker-compose ps`  
8- Aparecerá 2 container, um referente ao Banco de Dados (db), e outro específico do novoSGA;  
10- Identificar o nome do container do novoSGA;  
11- Agora é necessário executar os comandos:  
```powershell
	docker exec nome_do_container chown www-data:www-data /var/www/html/novosga/
	docker exec nome_do_container chmod 777 /var/www/html/novosga/var/
	docker exec nome_do_container chmod 777 /var/www/html/novosga/config/
	docker exec nome_do_container a2enmod rewrite
	docker exec nome_do_container service apache2 restart

	# Necessário executar novamente o container após o restart do apache
	docker-compose up -d
```  

##### Agora, com as permissões concluídas, é preciso executar um comando para instalar as dependências do projeto novoSGA para funcionar corretamente
12- Para isso digite o comando: `docker exec -i nome_do_container bash -c "cd novosga/ && composer install"`  


##### Após a conclusão do composer install, o sistema estará disponível para acesso pelo navegador.
13- Para acessar o container, é necessário saber qual IP aponta para o container, executando o comando: `docker exec nome_do_container cat /etc/hosts`  
14- O IP que em sua descrição conter números identificadores, é o IP de uso para acesso ao navegador;  
15- Agora é só digitar o IP no navegador, seguido de /novosga/public `IP_DO_CONTAINER/novosga/public`  


##### Assim você terá acesso ao sistema do novoSGA.
No primeiro acesso ao sistema, será necessário fazer a instalação do mesmo, que irá configurar perfil administrador de login, acesso ao banco de dados e outras informações necessárias, para isso é só seguir apresentados no próprio site, com algumas informações listadas a seguir:  
* Banco de dados MySQL/MariaDB
* Host do banco de dados: IP com descrição de db quando digitado o comando do passo 13
* Porta: 3306
* Usuário do banco de dados: root
* Senha do banco de dados: phprs
* Nome da base de dados: phprs
