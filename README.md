# start-docker
Para aplicações em PHP:

## Instalação
1. Mova seus arquivos da aplicação para a pasta Ex.: `/www/aplicacao`
2. Verifique o usuario no `Dockerfile` na linha 4 `ARG USERNAME=nome do seu usuario`
3. Exemplo de estrutura de pasta:
  - `Dockerfile`
  - `php.ini`
  - `docker-compose.yaml`
  - `www/aplicacao`
4. Execute o comando `docker compose build`
5. Depois `docker compose up -d`

## Dicas
- Para instalar npm e composer, entre na pasta do projeto `cd www/aplicacao/`
- Execute o comando `docker compose exec web-aplicacao bash` (web-aplicacao esta em no arquivo .yaml services)
- Após este comando você vai entrar no bash, rode o comando `ls -la` liste a pasta e entre na pasta do projeto
- Em seguinda você pode executar o composer e npm
