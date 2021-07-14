Database

Você deve criar um arquivo database.ini com o seguinte conteúdo.
```
[postgresql]
host=localhost
database=turismo_bd
user=seu_user
password=sua_senha
```
psql -U postgres -a -q -f esquema.sql <br>
psql -U postgres -d turismo_bd -a -q -f schemas.sql